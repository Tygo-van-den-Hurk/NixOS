#!/usr/bin/env bash
# Script from: https://github.com/OmarSkalli/waybar-tailscale
# Licensed under MIT. Thanks to, Omar Skalli.

# Colors will be injected later by stylix, or can be
# overridden on a per color basis:
color_blue="${color_blue:-"${base0D:-"#87CEEB"}"}"
color_green="${color_green:-"${base0B:-"#00ff00"}"}"
color_gray="${color_gray:-"${base04:-"#888888"}"}"
color_red="${color_red:-"${base08:-"#FF0000"}"}"

STATE_FILE="/tmp/waybar_tailscale_state"
CONNECTING_DURATION=2 # seconds to show transition states

get_tailscale_status() {

  local status_json=""
  status_json=$(tailscale status --json 2>/dev/null) || {
    echo "stopped"
    return
  }

  local backend_state=""
  backend_state=$(echo "$status_json" | jq -r '.BackendState // "NoState"')

  case "$backend_state" in
  "Running")
    echo "connected"
    ;;
  "Stopped" | "NoState" | "NeedsLogin")
    echo "stopped"
    ;;
  *)
    echo "stopped"
    ;;
  esac
}

get_tooltip() {

  local status_json=""
  if ! status_json=$(tailscale status --json 2>/dev/null); then
    echo ""
    return
  fi

  local backend_state=""
  backend_state=$(echo "$status_json" | jq -r '.BackendState // "NoState"')
  if [[ $backend_state != "Running" ]]; then
    echo ""
    return
  fi

  # Get current hostname
  local hostname=""
  hostname=$(echo "$status_json" | jq -r '.Self.HostName // "Unknown"')

  # Build tooltip with hostname and peers using Pango markup
  local tooltip
  tooltip="<b>Hostname: <span foreground='$color_blue'>$hostname</span></b>\n"
  tooltip+="\n<big><b>Peers</b></big>:"

  # Get peers and their status
  local peers=""
  peers=$(echo "$status_json" | jq -r '.Peer // {} | to_entries[] | "\(.value.HostName):\(.value.Online)"' | sort)
  [[ -n $peers ]] || {
    tooltip+="\n<i><span foreground='$color_gray'>No peers</span></i>"
    echo "$tooltip"
    return
  }

  while IFS=: read -r peer_name peer_online; do
    [[ $peer_name == "localhost" ]] && continue
    if [[ $peer_online == "true" ]]; then
      tooltip+="\n<span foreground='$color_green'>●</span> $peer_name"
    else
      tooltip+="\n<span foreground='$color_red'>●</span> <span foreground='$color_gray'>$peer_name</span>"
    fi
  done <<<"$peers"

  echo "$tooltip"
}

show_status() {

  local status=""
  local text=""
  local alt=""
  local tooltip=""

  status=$(get_tailscale_status)
  case $status in
  "connected")
    text=""
    alt="connected"
    tooltip=$(get_tooltip)
    ;;
  "stopped")
    text=""
    alt="stopped"
    tooltip="Tailscale is turned off"
    ;;
  esac

  if [[ -n $tooltip ]]; then
    echo "{\"text\":\"$text\",\"class\":\"$status\",\"alt\":\"$alt\",\"tooltip\":\"$tooltip\"}"
  else
    echo "{\"text\":\"$text\",\"class\":\"$status\",\"alt\":\"$alt\"}"
  fi
}

show_connecting() {
  echo '{"text":"","class":"connecting","alt":"connecting","tooltip":"Connecting..."}'
}

show_disconnecting() {
  echo '{"text":"","class":"disconnecting","alt":"disconnecting","tooltip":"Disconnecting..."}'
}

is_in_transition() {

  local state_info=""
  local state_time=""
  local current_time=""

  [[ -f $STATE_FILE ]] || return 1 # no state file

  state_info=$(cat "$STATE_FILE")
  state_time=$(echo "$state_info" | cut -d: -f1)
  current_time=$(date +%s)

  if ((current_time - state_time >= CONNECTING_DURATION)); then
    rm -f "$STATE_FILE"
    return 1 # not in transition
  fi

  return 0 # in transition
}

case "$1" in

--status)
  # Check if we're in a transition state
  if is_in_transition; then
    state_info=$(cat "$STATE_FILE")
    state_action=$(echo "$state_info" | cut -d: -f2)

    if [[ $state_action == "connecting" ]]; then
      show_connecting
      exit 0
    elif [[ $state_action == "disconnecting" ]]; then
      show_disconnecting
      exit 0
    fi
  fi

  show_status
  ;;
--toggle)
  # Don't allow toggle during transition
  if is_in_transition; then
    # Just show current transition state and exit
    state_info=$(cat "$STATE_FILE")
    state_action=$(echo "$state_info" | cut -d: -f2)

    if [[ $state_action == "connecting" ]]; then
      show_connecting
    elif [[ $state_action == "disconnecting" ]]; then
      show_disconnecting
    fi
    exit 0
  fi

  # Determine the action and mark the start of transition state
  current_status=$(get_tailscale_status)
  if [[ $current_status == "connected" ]]; then
    # echo "$(date +%s):disconnecting" > "$STATE_FILE"
    # Make disconnects instant
    tailscale down
    show_status
  else
    echo "$(date +%s):connecting" >"$STATE_FILE"
    tailscale up
    show_connecting
  fi
  ;;

*)
  echo "Usage: $0 <--status|--toggle>"
  exit 1
  ;;

esac
