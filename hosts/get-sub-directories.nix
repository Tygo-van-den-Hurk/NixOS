directory:
let
  # Read the directory.
  inherit (builtins) readDir;
  files = readDir directory;

  # Get the entries.
  inherit (builtins) attrNames;
  entries = attrNames files;

  # Filter them for directories only.
  inherit (builtins) filter;
  isDirectory = file: files.${file} == "directory";
  directories = filter isDirectory entries;
in
directories
