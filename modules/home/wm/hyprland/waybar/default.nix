{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "wm";
  program = "waybar";
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

  config.assertions = [
    {
      assertion = cfg.enable -> (config.stylix.enable or false);
      message =
        "When you enable the '${namespace}.${type}.${program}.enable' option, "
        + "then you must enable stylix for its 16 bit scheme.";
    }
  ];

  config.programs.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    style = builtins.readFile ./style.css;
    settings.mainBar = {
      layer = "top";
      position = "top";

      modules-left = [
        "hyprland/workspaces"
      ];

      modules-center = [
        "clock"
      ];

      modules-right = [
        "pulseaudio"
        "network"
        "battery"
        "battery#bat2"
      ];
    };
  };

  config.wayland.windowManager.hyprland.settings = mkIf cfg.enable {
    exec-once = [ "${getExe config.programs.waybar.package} # waybar init" ];
  };
}
