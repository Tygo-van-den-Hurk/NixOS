{ inputs, ... }:
let
  namespace = "self";
  module = "cli";
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
      cfg = config.${namespace}.${module};
    in
    {
      options.${namespace}.${module} = with types; {
        enable = mkOption {
          description = "Whether to enable CLI applications and terminal based tools.";
          default = false;
          type = bool;
        };
      };

      config.home = mkIf cfg.enable {
        packages = with pkgs; [
          undollar
        ];
      };

      imports = inputs.self.lib.import-recursively {
        base = ./.;
        exclude = ./default.nix;
      };
    };
}
