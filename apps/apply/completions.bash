# shellcheck shell=bash
# shellcheck disable=SC2034

_x_apply_script_completions() {
  local cur prev
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"

  # suggest flags if current word starts with -
  local opts="-h --help -v --verbose -q --quiet -H --hostname -U --username -P --flake-path -- --update"
  mapfile -t COMPREPLY < <(compgen -W "$opts" -- "$cur")
  return 0
}

complete -F _x_apply_script_completions apply
