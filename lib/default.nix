{
  inputs,
  ...
}:
let
  inherit (inputs.nixpkgs) lib;
in
{
  flake.lib = rec {

    find-files = import ./find-files lib;

    # old name and contract
    import-recursively =
      args@{
        extension ? null,
        extensions ? null,
        ...
      }:
      if extension != null || extensions != null then
        find-files args
      else
        find-files (
          args
          // {
            extension = null;
            extensions = [ ".nix" ];
          }
        );

    replace-words = import ./replace-words;

    # old name and contract (switched argument order)
    replaceAttrs = string: set: replace-words set string;
  };

  perSystem = { pkgs, lib, ... }: {
    checks.find-files = import ./find-files/tests.nix {
      inherit pkgs;
      inherit lib;
    };

    checks.replace-words = import ./replace-words/tests.nix {
      inherit pkgs;
      inherit lib;
    };
  };
}
