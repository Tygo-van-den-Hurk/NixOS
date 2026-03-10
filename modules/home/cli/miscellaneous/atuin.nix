{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "miscellaneous";
  program = "atuin";
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

  config.programs.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    daemon.enable = mkDefault true;
    enableBashIntegration = mkDefault true;
    enableFishIntegration = mkDefault true;
    enableNushellIntegration = mkDefault true;
    enableZshIntegration = mkDefault true;
    forceOverwriteSettings = mkDefault true;
  };
}
