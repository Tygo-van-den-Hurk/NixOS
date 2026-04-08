#!/usr/bin/env bash
set -euo pipefail

# Basic path sanity checks
root="$(git rev-parse --show-toplevel)"
echo "root=$root" >&2
workflow_dir="$root/.github/workflows"
echo "workflow_dir=$workflow_dir" >&2
if [ ! -d "$workflow_dir" ]; then
  echo "No such file or directory: $workflow_dir" >&2
  exit 1
fi

# Check if all files are .nix.yml files to not lose track of what is generated
mapfile -t results < <(nix build .#workflows --no-link --print-out-paths)
echo "results=${results[*]}" >&2
for result in "${results[@]}"; do
  for file in "$result"/*; do
    [ -f "$file" ] || continue
    case "$file" in
    *.nix.yml) ;;
    *)
      echo "Expected '$file' to end in '.nix.yml'."
      exit 1
      ;;
    esac
  done
done

# remove old workflow files, and replace with new ones
shopt -s dotglob
rm -f "$workflow_dir"/*.nix.yml
for result in "${results[@]}"; do
  install --mode=644 "$result"/* "$workflow_dir"
done
shopt -u dotglob
