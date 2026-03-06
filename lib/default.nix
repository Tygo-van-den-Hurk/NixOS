{
  inputs,
  ...
}:
let
  inherit (inputs.nixpkgs) lib;
in
{
  flake.lib = {
    import-recursively =
      {
        base,
        exclude ? null, # no file to exclude
        extension ? ".nix", # the file extension
        extra ? [ ], # extra imports to include outside of this directory.
        transform ? (value: value), # transforms a file using this function
      }:

      assert builtins.isPath base;

      assert exclude == null || builtins.isPath exclude;

      assert builtins.isString extension;

      assert builtins.isList extra;

      let
        files = lib.fileset.toList base;
        isNotExclude = file: file != exclude;
        hasExtension = file: lib.hasSuffix extension file;
        filterFn = file: (isNotExclude file) && (hasExtension file);
        result = builtins.filter filterFn files;
      in
      builtins.map transform (result ++ extra);

    replaceAttrs =
      string: set:
      builtins.foldl' (acc: key: builtins.replaceStrings [ "${key}" ] [ set.${key} ] acc) string (
        builtins.attrNames set
      );
  };
}
