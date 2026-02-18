{ inputs, ... }:
let
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
      options.${module} = with types; {
        enable = mkOption {
          description = "Whether to load the defaults for all systems.";
          default = true;
          readOnly = true;
          type = bool;
        };
      };

      imports = inputs.self.lib.import-recursively {
        base = ./.;
        exclude = ./default.nix;
      };
    };
}
