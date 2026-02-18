{ inputs, ... }:
let
  module = "gui";
in
{
  flake.homeModules.${module} =
    {
      lib,
      ...
    }:
    with lib;
    {
      options.${module} = with types; {
        enable = mkOption {
          description = "Whether to enable GUI applications and tools.";
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
