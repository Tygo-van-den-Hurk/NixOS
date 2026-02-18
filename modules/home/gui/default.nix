{ inputs, ... }:
let
  module = "gui";
in
{
  flake.homeModules.${module} =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    with lib;
    let
      cfg = config.${module};
    in
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
