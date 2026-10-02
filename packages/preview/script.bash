#!/usr/bin/env bash
# Shebang will be overwritten by write shell script bin function, this is just for backwards compatibility.

set -e

version_of_the_program="v0.6.4"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Exit Codes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

#
NO_SUCH_FILE_OR_DIRECTORY_EXIT_CODE=1
NO_SUCH_OPTION_OR_FLAG_EXIT_CODE=2
WRONG_COLOR_OPTION_EXIT_CODE=3
INCORRECT_USAGE_EXIT_CODE=4
SUCCESS_EXIT_CODE=0

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Messages ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

## Prints a message on how to use this program
print_usage() {
  echo "Incorrect usage. Correct usage:"
  echo ""
  echo "  $0 [arguments...] <files...>"
  echo ""
  echo "use the --help flag for more information and possible arguments."
}

# checks if at least one file or argument is provided.
if [ -z "$1" ]; then
  print_usage >&2
  exit $INCORRECT_USAGE_EXIT_CODE
fi

## prints a help message.
print_help() {
  echo "Preview files or directories from your computer in the terminal."
  echo ""
  echo "Usage: $0 [arguments...] <files...>"
  echo ""
  echo "Valid arguments:"
  echo ""
  echo "  -h, --help             | Displays this help message."
  echo "  -V, --version          | output the version of this program and exit."
  echo "  -t, --tree             | Displays directories in tree form."
  echo "  -a, --ascii            | Only print ascii do not use image protocol."
  echo "  -v, --verbose          | Whether to be verbose and print extra information."
  echo "  -c, --color, --colour  | Whether or not to print colored output."
  echo "                         | One of: 'auto', 'always', or 'never'."
  echo ""
  echo "Use '--' to stop consuming arguments. Next arguments are not used anywhere."
  echo ""
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Argument Parsing ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

# Separates --option=value into '--option' and 'value'.
new_args=()
while [[ $# -gt 0 ]]; do
  case "$1" in
  --*=*)
    key="${1%%=*}"
    val="${1#*=}"
    new_args+=("$key" "$val")
    shift
    ;;
  *)
    new_args+=("$1")
    shift
    ;;
  esac
done

set -- "${new_args[@]}"

# parsing the separated arguments

files_and_dirs=()
verbose="false"
color="auto"
ascii="false"
tree="false"

# Parsing the arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
  -h | --help)
    print_help >&2
    exit $SUCCESS_EXIT_CODE
    ;;
  -t | --tree)
    tree="true"
    shift
    ;;
  -a | --ascii)
    ascii="true"
    shift
    ;;
  -v | --verbose)
    verbose="true"
    shift
    ;;
  -V | --version)
    echo "$version_of_the_program"
    exit $SUCCESS_EXIT_CODE
    ;;
  -c | --color | --colour)
    color="$2"
    if [[ ! $color =~ ^(always|never|auto)$ ]]; then
      echo "The color option is supposed to be one of:" >&2
      echo "" >&2
      echo "- always" >&2
      echo "- never" >&2
      echo "- auto" >&2
      echo "" >&2
      echo "But found '$color'." >&2
      exit $WRONG_COLOR_OPTION_EXIT_CODE
    fi
    shift 2
    ;;
  --)
    shift
    break
    ;;
  -*)
    echo "Unknown option: $1" >&2
    exit $NO_SUCH_OPTION_OR_FLAG_EXIT_CODE
    ;;
  *)
    path="$1"
    shift
    if [ ! -e "$argument" ]; then
      files_and_dirs+=("$path")
    else
      echo "No such file or directory: $argument"
      exit $NO_SUCH_FILE_OR_DIRECTORY_EXIT_CODE
    fi
    ;;
  esac
done

if [[ $verbose == "true" ]]; then
  echo "Arguments parsed:" >&2
  echo "- verbose=$verbose" >&2
  echo "- tree=$tree" >&2
  echo "- ascii=$ascii" >&2
  echo "- color=$color" >&2
fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Helper Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

# Gets the file extension of a file path
function get_file_extension() {
  local filename
  filename=$(basename -- "$1")
  if [[ $filename == *.* ]]; then
    echo "${filename##*.}"
  else
    echo ""
  fi
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Function wrappers to display certain types ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

# Displays the image provided.
function display_image() {
  local extension
  extension=$(get_file_extension "$1")

  extra_arguments=()
  if [[ $ascii == "true" ]]; then
    extra_arguments+=("--format=symbols")
  fi

  if [[ $color == "never" ]]; then
    extra_arguments+=("--colors=2" "--format=symbols")
  fi

  case "${extension,,}" in
  gif)
    chafa "$@" "${extra_arguments[@]}" --duration=5
    ;;
  *)
    chafa "$@" "${extra_arguments[@]}"
    ;;
  esac

  return "$?"
}

# Displays the ascii text provided.
function display_text() {
  local extension
  extension=$(get_file_extension "$1")

  case "${extension,,}" in
  md | markdown)
    glow --width "$(tput cols)" "$@"
    ;;
  ipynb)
    nbcat "$@"
    ;;
  *)
    bat --style=plain --color="$color" --pager=never "$@"
    ;;
  esac

  return "$?"
}

# Displays the ascii text provided.
function display_binary() {
  local extension argument format location
  extension=$(get_file_extension "$1")

  # trying to interpret binary files
  case "${extension,,}" in
  gif | png | jpeg | jpg)
    display_image "$1"
    ;;
  pdf)
    format="png"
    location="/tmp/preview-pdf-to-image"
    pdftoppm -singlefile "$1" "-$format" "$location" -q
    display_image "$location.$format"
    rm "$location.$format"
    ;;
  *)
    echo -n "Unknown Binary file type: '$1'." > /dev/stderr
    echo -n "Attempted to match on extension '$extension'" > /dev/stderr
    echo "but found no result." > /dev/stderr
    ;;
  esac

  return $?
}

# Displays the ascii text provided.
function display_directory() {

  extra_arguments=()
  if [[ $tree == "true" ]]; then
    extra_arguments+=("--tree")
  elif [[ $ascii != "true" ]]; then
    extra_arguments+=("--icons")
  fi

  eza --no-quotes --git --long --no-time --smart-group --group-directories-first \
    "$@" --color "$color" "${extra_arguments[@]}"
  return $?
}

if [[ $verbose == "true" ]]; then
  echo "Functions initialized" >&2
fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Sorting and Calling Display Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

if [[ ${#files_and_dirs[@]} -eq 0 ]]; then
  echo "No files or directories to preview provided..." >&2
  print_usage >&2
  exit $INCORRECT_USAGE_EXIT_CODE
fi

# looping over all directories and files
for file_or_directory in "${files_and_dirs[@]}"; do
  result="$(file --dereference "$file_or_directory")"
  output="${result#"$file_or_directory":' '}"
  case "${output,,}" in
  *directory*)
    display_directory "$file_or_directory"
    ;;
  *image*)
    display_image "$file_or_directory"
    ;;
  *empty* | *short*)
    echo "The file '$file_or_directory' is empty..."
    ;;
  *data* | *pdf*)
    display_binary "$file_or_directory"
    ;;
  *text* | *)
    display_text "$file_or_directory"
    ;;
  esac
done

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
