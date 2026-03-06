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
    "hyprland/workspaces" = {
      format = "{icon}";
      format-icons = {
        "active" = "";
        "default" = "";
      };

      disable-scroll = false;
      on-scroll-up = "hyprctl dispatch workspace e-1";
      on-scroll-down = "hyprctl dispatch workspace e+1";
    };
  };
}
