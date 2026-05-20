#!/usr/bin/env bash
# Shebang will be overwritten by write shell script bin function, this is just for backwards compatibility.

set -e

## Tries a bunch of common locking programs, and invokes the first one found.
function try_locking() {
  for locker in "$@"; do
    if command -v "$locker" >/dev/null; then
      echo "$locker is installed, assuming this is your locker..."
      eval "$locker"
      return 0
    fi
  done

  echo "Could not find your preferred locking application."
  echo "Try setting the HIBERNATE_COMMAND environment variable."
  exit 1
}

## Tries to detect the current WM/compositor, and find a matching locker.
function try_finding_locker() {
  if pgrep -x Hyprland >/dev/null; then
    echo "Hyprland is running: assuming Wayland..."
    echo "Trying to find your preferred locking program based on this information..."
    try_locking swaylock hyprlock gtklock swaylock-effects kscreenlocker_greet

  elif pgrep -x i3 >/dev/null; then
    echo "i3 is running: assuming X11..."
    echo "Trying to find your preferred locking program based on this information..."
    try_locking i3lock swaylock hyprlock xlock slock betterlockscreen \
      xsecurelock xscreensaver gnome-screensaver light-locker

  else
    echo "Could not detect a known WM/compositor. Assuming TTY..."
    echo "Trying to find a suitable TTY locker..."
    try_locking physlock
  fi
}

## Tries to hibernate the system
function try_hibernating() {
  echo "Attempting to hibernate..."

  # First, try systemd
  if command -v systemctl >/dev/null; then
    if systemctl hibernate; then
      echo "Hibernated using systemctl."
      return 0
    fi
  fi

  # Try loginctl (some systems restrict hibernation per-session)
  if command -v loginctl >/dev/null; then
    if loginctl hibernate; then
      echo "Hibernated using loginctl."
      return 0
    fi
  fi

  # Try dbus (used in GNOME, KDE and some other desktops)
  if command -v dbus-send >/dev/null; then
    if dbus-send --system --print-reply \
      --dest=org.freedesktop.login1 \
      /org/freedesktop/login1 \
      org.freedesktop.login1.Manager.Hibernate boolean:true; then
      echo "Hibernated using dbus-send."
      return 0
    fi
  fi

  # Try writing to /sys/power/state (requires root)
  if [ -w /sys/power/state ]; then
    if grep -q 'hibernate' /sys/power/state; then
      echo "disk" >/sys/power/state && echo "Hibernated by writing to /sys/power/state." && return 0
    fi
  fi

  echo "All known hibernation methods failed. System may not support hibernation or requires special permissions."
  echo "Try setting the HIBERNATE_COMMAND environment variable."
  exit 1
}

if [ -n "$HIBERNATE_COMMAND" ]; then
  echo "The environment variable 'HIBERNATE_COMMAND' is set. Invoking that command..."
  eval "$HIBERNATE_COMMAND"
else
  echo "The environment variable 'HIBERNATE_COMMAND' is not set."
  echo "Try setting the HIBERNATE_COMMAND environment variable for best results like so:"
  echo "  export HIBERNATE_COMMAND='your-locking-program --lock && your-hibernation-command --hibernate'"
  echo "Trying to find the preferred locker manually..."
  try_finding_locker
  echo "Trying to find the preferred hibernate command manually..."
  try_hibernating
fi

echo "ran successfully!"
