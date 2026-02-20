{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  type = "gui";
  category = "messengers";
  program = "discord";
  cfg = config.${type}.${category}.${program};
in
{
  options.${type}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${type}.${category}.enable;
      type = bool;
    };
  };

  config.nixpkgs.config = mkIf cfg.enable {
    allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "discord"
      ];
  };

  config.home = mkIf cfg.enable {
    packages = with pkgs; [
      discord
    ];
  };
}
