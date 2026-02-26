# shellcheck shell=bash
# shellcheck disable=SC2034

_x_apply_script_completions() {
  local cur prev
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"

  # suggest flags if current word starts with -
  local help="-h --help"
  local verbose="-v --verbose"
  local quiet="-q --quiet"
  local hostname="-H --hostname"
  local username="-U --username"
  local flake_path="-P --flake-path"
  local home_manager="-M --home-manager"
  local nixos="-N --nixos"
  local update="-u --update"
  local command="-c --command"
  local opts="$help $verbose $quiet $hostname $username $flake_path $home_manager $nixos $update $command --"
  mapfile -t COMPREPLY < <(compgen -W "$opts" -- "$cur")
  return 0
}

complete -F _x_apply_script_completions apply
