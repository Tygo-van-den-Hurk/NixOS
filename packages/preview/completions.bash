# shellcheck shell=bash

_preview() {
  local cur prev
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"

  case "$prev" in
  -c | --color | --colour)
    local opts="never auto always"
    mapfile -t COMPREPLY < <(compgen -W "$opts" -- "$cur")
    return 0
    ;;
  esac

  # suggest flags if current word starts with -
  if [[ $cur == --color=* ]]; then
    local opts="--color=auto --color=never --color=always"
    mapfile -t COMPREPLY < <(compgen -W "$opts" -- "$cur")
  elif [[ $cur == --color=* || $cur == --colour=* ]]; then
    local opts="--colour=auto --colour=never --colour=always"
    mapfile -t COMPREPLY < <(compgen -W "$opts" -- "$cur")
    return 0
  elif [[ $cur == -* ]]; then
    local opts="--help --ascii --tree --verbose --version --color --color= --"
    mapfile -t COMPREPLY < <(compgen -W "$opts" -- "$cur")
    return 0
  fi

  # otherwise, suggest files/dirs
  mapfile -t COMPREPLY < <(compgen -df -- "$cur")

  # prevent space after directories
  if compgen -d -- "$cur" >/dev/null; then
    compopt -o nospace
  fi

  return 0
}

complete -F _preview preview
