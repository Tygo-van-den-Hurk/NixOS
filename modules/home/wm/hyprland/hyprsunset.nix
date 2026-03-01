{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "wm";
  program = "hyprsunset";
  cfg = config.${namespace}.${type}.${program};
in
{
  options.${namespace}.${type}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.hyprland.enable;
      type = bool;
    };
  };

  config.services.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    settings = {
      max-gamma = 150;
      profile = [
        {
          time = "9:30";
          identity = true;
        }
        {
          time = "19:30";
          temperature = 5000;
          gamma = 0.8;
        }
      ];
    };
  };
}
