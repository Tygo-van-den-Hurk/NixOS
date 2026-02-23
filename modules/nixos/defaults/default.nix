{ inputs, ... }:
let
  namespace = "self";
  module = "defaults";
in
{
  flake.nixosModules.${module} =
    {
      lib,
      ...
    }:
    with lib;
    {
      options.${namespace}.${module} = with types; {
        enable = mkOption {
          description = "Whether to load the defaults for all systems.";
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
