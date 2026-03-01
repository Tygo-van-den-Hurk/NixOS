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
    };
  };
}
