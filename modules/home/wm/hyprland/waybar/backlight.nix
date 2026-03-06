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
  config.programs.${program}.settings = mkIf cfg.enable {

    mainBar.backlight = {
      reverse-scrolling = true;
    };

    mainBar.backlight = {
      format = "<span size='large'>{icon}</span> {percent}%";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
      ];
    };

    mainBar.backlight = {
      tooltip = true;
      tooltip-format = strings.trim ''
        <b>Brightness</b>: {percent}%
      '';
    };
  };
}
