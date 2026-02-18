{ inputs, ... }:
let
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
      cfg = config.${module};
    in
    {
      options.${module} = with types; {
        enable = mkOption {
          description = "Whether to enable CLI applications and terminal based tools.";
          default = false;
          type = bool;
        };
      };

      config.home = mkIf cfg.enable {
        packages = with pkgs; [
          undollar
          # Ricing packages: might be moved into its own module at some point:
          cava
          cmatrix
          figlet
          lolcat
          fastfetch
          pipes
          cowsay
        ];
      };

      imports = inputs.self.lib.import-recursively {
        base = ./.;
        exclude = ./default.nix;
      };
    };
}
