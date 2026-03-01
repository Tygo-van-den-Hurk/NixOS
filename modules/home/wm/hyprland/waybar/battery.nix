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
  config.programs.${program}.settings.mainBar = mkIf cfg.enable {
    battery.states = {
      good = 95;
      warning = 30;
      critical = 15;
    };

    battery = {
      format = "{icon} {capacity}%";
      format-full = "{icon} {capacity}%";
      format-charging = "{capacity}% ";
      format-plugged = "{capacity}% ";
      format-alt = "{time} {icon}";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
      ];
    };

    "battery#bat2".bat = "BAT2";
  };
}
