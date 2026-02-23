{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  category = "wm";
  program = "hyprland";
  cfg = config.${namespace}.${category}.${program};
in
{
  config.wayland.windowManager.${program}.settings = mkIf cfg.enable {
    bind =
      let
        shortcutToString =
          description: instance:
          if !instance.enable then
            null
          else
            let
              control = if instance.control then "CTRL" else null;
              option = if instance.option then "ALT" else null;
              shift = if instance.shift then "SHIFT" else null;
              super = if instance.super then "SUPER" else null;
              mods = filter (mod: mod != null) [
                control
                option
                shift
                super
              ];
              modifier = concatStringsSep "_" mods;
            in
            "${modifier}, ${instance.key}, ${instance.action.hyprland} # ${description}";
      in
      mapAttrsToList shortcutToString config.${namespace}.${category}.shortcuts;
  };
}
