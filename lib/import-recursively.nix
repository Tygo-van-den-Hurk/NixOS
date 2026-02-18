{
  inputs,
  ...
}:
with builtins;
with inputs.nixpkgs.lib;
{
  flake.lib.import-recursively =
    {
      base,
      exclude ? null, # no file to exclude
      extension ? ".nix", # the file extension
      extra ? [ ], # extra imports to include outside of this directory.
    }:

    assert isPath base;

    assert exclude == null || isPath exclude;

    assert isString extension;

    assert isList extra;

    let
      files = fileset.toList base;
      isNotExclude = file: file != exclude;
      hasExtension = file: hasSuffix extension file;
      filterFn = file: (isNotExclude file) && (hasExtension file);
      result = filter filterFn files;
    in
    result ++ extra;
}
