lib:
let
  inherit (lib) fileset;
  inherit (lib) hasSuffix;
in

{
  base,
  exclude ? null, # no file to exclude
  extension ? null, # the file extension
  extensions ? null,
  extra ? [ ], # extra imports to include outside of this directory.
  transform ? (value: value), # transforms a file using this function
}:

# Files that should always be included in the result.
assert builtins.isList extra;
assert builtins.isPath base;
let
  all_files = fileset.toList base;
in

# Files to exclude from the list of target files
assert
  exclude == null
  || builtins.isPath exclude
  || (builtins.isList exclude && builtins.all builtins.isPath exclude);

let
  files_to_exclude =
    if exclude == null then
      [ ]
    else if builtins.isPath exclude then
      [ exclude ]
    else if builtins.isList exclude && builtins.all builtins.isPath exclude then
      exclude
    else
      throw "exclude is supposed to be null, a path, or a list of paths.";

  is_not_excluded = file: !builtins.elem file files_to_exclude;
  non_excluded_files = builtins.filter is_not_excluded all_files;
in

# file extension of the target files
assert extension == null || builtins.isString extension;
assert
  extensions == null || (builtins.isList extensions && builtins.all builtins.isString extensions);

let
  file_extensions =
    (if extension == null then [ ] else [ extension ])
    ++ (if extensions == null then [ ] else extensions);

  has_file_extension =
    file: file_extensions == [ ] || builtins.any (extension: hasSuffix extension file) file_extensions;

  has_right_extension = builtins.filter has_file_extension non_excluded_files;
in

builtins.map transform (has_right_extension ++ extra)
