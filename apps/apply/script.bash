#!/usr/bin/env bash

set -e

# Separates --option=value into '--option' and 'value'.
# Also splits compact short options like '-abc' into '-a' '-b' '-c'.
new_args=()
while [[ $# -gt 0 ]]; do
  case "$1" in
  -*=*)
    # Handle --option=value
    key="${1%%=*}"
    val="${1#*=}"
    new_args+=("$key" "$val")
    shift
    ;;
  -[!-]?*)
    # Handle compact short options (e.g. -abc)
    flags="${1#-}"
    for ((i = 0; i < ${#flags}; i++)); do
      new_args+=("-${flags:i:1}")
    done
    shift
    ;;
  *)
    new_args+=("$1")
    shift
    ;;
  esac
done

set -- "${new_args[@]}"

function print_help() {
  echo "Options:                                                                        "
  echo "                                                                                "
  echo "  -U, --username        The username to use when looking up a home-manager      "
  echo "                        configuration. Defaults to the current user: $(whoami)  "
  echo "  -H, --hostname        The hostname to use when looking up a configuration.    "
  echo "                        defaults to the machines hostname.                      "
  echo "  -P, --flake-path      The path to the flake, if not provided falls back to    "
  echo "                        the current directory instead. Can also be a flake URL. "
  echo "  -q, --quiet           Print no information. Cannot be combined with the       "
  echo "                        '--verbose' flag. Will exit with failure if combined.   "
  echo "  -v, --verbose         Print all information. Cannot be combined with the      "
  echo "                        '--quiet' flag. Will exit with failure if combined.     "
  echo "      --                Stop parsing arguments and pass all further arguments   "
  echo "                        to the respective rebuild function instead.             "
  echo "      --update          Update the flake.lock file before rebuilding. Be aware: "
  echo "                        this tool does not commit those changes. Also only works"
  echo "                        if flake path is not provided as we assume to update the"
  echo "                        flake in the current directory.                         "
  echo "  -h, --help            print this help message and then exit.                  "
}

update="0"
username="$(whoami)"
hostname="$(hostname)"
flake_path="$(pwd)"
verbose="0"
quiet="0"

# Loop through arguments
while [[ $# -gt 0 ]]; do
  case $1 in
  -U | --username)
    shift
    username="$1"
    shift
    ;;
  -H | --hostname)
    shift
    hostname="$1"
    shift
    ;;
  -P | --flake-path)
    shift
    flake_path="$1"
    shift
    ;;
  -q | --quiet)
    quiet=1
    shift
    ;;
  -v | --verbose)
    verbose=1
    shift
    ;;
  --update)
    update="1"
    shift
    ;;
  -h | --help)
    print_help
    exit 0
    ;;
  --)
    shift
    break
    ;;
  *)
    echo "Incorrect usage: unknown option: '$1', please see '--help'."
    echo
    print_help
    exit 1
    ;;
  esac
done

# if `--verbose` and `--quiet`:
if [ $verbose -eq 1 ]; then
  if [ $quiet -eq 1 ]; then
    echo "Incorrect usage: cannot combine '--verbose' and '--quiet' flag."
    exit 2
  fi

  echo "verbose debug information:"
  echo "  username='$username'"
  echo "  hostname='$hostname'"
  echo "  flake_path='$flake_path'"
  echo "  verbose='$verbose'"
  echo "  quiet='$quiet'"
fi

# prints output, unless quiet.
function print() {
  if [[ $quiet -eq 1 ]]; then
    return
  else
    echo "$@"
  fi
}

function rebuild_nixos_config() {
  local extra_args=()

  if [ $verbose -eq 1 ]; then
    local extra_args+=(--print-build-logs)
    local extra_args+=(--verbose)
  fi

  if [ $quiet -eq 1 ]; then
    local extra_args+=(--quiet)
  fi

  exec sudo nixos-rebuild "${extra_args[@]}" switch --flake "$flake_path#\"$hostname\"" "$@"
}

function rebuild_home-manager_config() {
  exec home-manager switch --flake "$flake_path#\"$username@$hostname\"" "$@"
}

# update the flake if no invalid arguments were provided.
if [ $update -eq 1 ]; then
  if [ "$flake_path" == "$(pwd)" ]; then
    nix flake update
  else
    echo "Incorrect usage: cannot combine '--flake-path' or '-P' with the '--update' flag."
    exit 2
  fi
fi

if [ -e /etc/NIXOS ]; then
  rebuild_nixos_config "$@"
else
  rebuild_home-manager_config "$@"
fi
