{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "gui";
  category = "messengers";
  program = "discord";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  options.${namespace}.${type}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.${category}.enable;
      type = bool;
    };
  };

  config.self.unfree = mkIf cfg.enable {
    packageAllowList = [
      "discord"
    ];
  };

  config.home = mkIf cfg.enable {
    packages = with pkgs; [
      discord
    ];
  };
}
