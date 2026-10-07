{
  inputs,
  ...
}:
let
  inherit (inputs.self.lib) find-files;
  namespace = "self";
  module = "cli";
in
{
  flake.homeModules.${module} =
    {
      config,
      pkgs,
      lib,
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

      imports = find-files {
        base = ./.;
        exclude = ./default.nix;
        extension = ".nix";
      };
    };
}
