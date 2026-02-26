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
  echo "  -N, --nixos           Switch to a new NixOS configuration with the resulting  "
  echo "                        hostname, regardless of whether the programs believes   "
  echo "                        you are on NixOS. Only use if you know what you're doing"
  echo "  -M, --home-manager    Switch to a new Home Manager configuration even if the  "
  echo "                        program believes you are on NixOS. Nice for when using  "
  echo "                        Home Manager in standalone modus.                       "
  echo "  -q, --quiet           Print no information. Cannot be combined with the       "
  echo "                        '--verbose' flag. Will exit with failure if combined.   "
  echo "  -v, --verbose         Print all information. Cannot be combined with the      "
  echo "                        '--quiet' flag. Will exit with failure if combined.     "
  echo "      --                Stop parsing arguments and pass all further arguments   "
  echo "                        to the respective rebuild function instead.             "
  echo "  -c, --command         The subcommand to run. Defaults to 'switch' allows you  "
  echo "                        instead of switch for example only 'test' the new one.  "
  echo "      --update          Update the flake.lock file before rebuilding. Be aware: "
  echo "                        this tool does not commit those changes. Also only works"
  echo "                        if flake path is not provided as we assume to update the"
  echo "                        flake in the current directory.                         "
  echo "  -h, --help            print this help message and then exit.                  "
  echo "                                                                                "
}

username="$(whoami)"
hostname="$(hostname)"
flake_path="$(pwd)"
command="switch"
nixos="0"
home_manager="0"
verbose="0"
quiet="0"
update="0"

# Loop through arguments
pass_through_arguments=()
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
  -N | --nixos)
    nixos="1"
    shift
    ;;
  -M | --home-manager)
    home_manager="1"
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
  -c | --command)
    shift
    command="$1"
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
    while [[ $# -gt 0 ]]; do
      pass_through_arguments+=("$1")
      shift
    done
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

# Colors text in a certain color
color() {
  local code
  case "$1" in
  black) code=30 ;;
  red) code=31 ;;
  green) code=32 ;;
  yellow) code=33 ;;
  blue) code=34 ;;
  magenta) code=35 ;;
  cyan) code=36 ;;
  white) code=37 ;;
  *)
    echo "unknown color '$1', exiting"
    exit 2
    ;;
  esac
  shift
  printf "\033[${code}m%s\033[0m" "$*"
}

# if `--verbose` and `--quiet`:
if [ $verbose -eq 1 ]; then
  if [ $quiet -eq 1 ]; then
    echo "$(color red Incorrect usage): cannot combine '--verbose' and '--quiet' flag."
    exit 2
  fi

  echo "verbose debug information:"
  echo "  $(color cyan username)=$(color yellow "'$username'")"
  echo "  $(color cyan hostname)=$(color yellow "'$hostname'")"
  echo "  $(color cyan flake_path)=$(color yellow "'$flake_path'")"
  echo "  $(color cyan nixos)=$(color yellow "'$nixos'")"
  echo "  $(color cyan home_manager)=$(color yellow "'$home_manager'")"
  echo "  $(color cyan verbose)=$(color yellow "'$verbose'")"
  echo "  $(color cyan quiet)=$(color yellow "'$quiet'")"
fi

# prints output, unless quiet.
function print() {
  if [[ $quiet -eq 1 ]]; then
    return
  else
    echo "$@"
  fi
}

extra_args=()
if [ $verbose -eq 1 ]; then
  extra_args+=(--print-build-logs)
  extra_args+=(--show-trace)
fi

function rebuild_nixos_config() {
  if [ $verbose -eq 1 ]; then
    extra_args+=(--verbose)
  fi

  if [ $quiet -eq 1 ]; then
    extra_args+=(--quiet)
  fi

  local configuration="$flake_path#\"$hostname\""
  echo "Switching to NixOS configuration: $(color blue "$configuration")"
  exec sudo nixos-rebuild "${extra_args[@]}" "$command" --flake "$configuration" "${pass_through_arguments[@]}"
}

function rebuild_home-manager_config() {
  if [ $verbose -eq 1 ]; then
    extra_args+=(-v)
  fi

  local configuration="$flake_path#\"$username@$hostname\""
  echo "Switching to Home Manager configuration: $(color blue "$configuration")"
  exec home-manager "$command" --flake "$configuration" "${pass_through_arguments[@]}"
}

# update the flake if no invalid arguments were provided.
if [ $update -eq 1 ]; then
  if [ "$flake_path" == "$(pwd)" ]; then
    git pull --rebase
    nix flake update
  else
    echo "$(color red Incorrect usage): cannot combine '--flake-path' or '-P' with the '--update' flag."
    exit 2
  fi
fi

# figure out what command to run.
if [ $nixos -eq 1 ]; then
  if [ $home_manager -eq 1 ]; then
    echo "$(color red Incorrect usage): cannot combine '--nixos' and '--home-manager' flags."
    exit 2
  fi
  rebuild_nixos_config
elif [ $home_manager -eq 1 ]; then
  rebuild_home-manager_config
else
  if [ -e /etc/NIXOS ]; then
    rebuild_nixos_config
  else
    rebuild_home-manager_config
  fi
fi
