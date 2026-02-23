{ inputs, ... }:
let
  namespace = "self";
  module = "wm";
in
{
  flake.homeModules.${module} =
    {
      lib,
      ...
    }:
    with lib;
    {
      options.${namespace}.${module} = with types; {
        enable = mkOption {
          description = "Whether to enabled window managers and their configs";
          default = false;
          type = bool;
        };
      };

      imports = inputs.self.lib.import-recursively {
        base = ./.;
        exclude = ./default.nix;
      };
    };
}
