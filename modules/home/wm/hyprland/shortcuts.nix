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
        inherit (config.${namespace}.${category}) shortcuts;
        enabledShortcuts = filterAttrs (_description: instance: instance.enable) shortcuts;
        shortcutToConfig = _description: instance: {
          _args =
            let
              inherit (instance) key;
              control = if instance.control then "CTRL" else null;
              option = if instance.option then "ALT" else null;
              shift = if instance.shift then "SHIFT" else null;
              super = if instance.super then "SUPER" else null;
              mods = filter (mod: mod != null) [
                control
                option
                shift
                super
                key
              ];
              modifiers = concatStringsSep " + " mods;
            in
            [
              modifiers
              instance.action.hyprland
            ];
        };
      in
      mapAttrsToList shortcutToConfig enabledShortcuts;
  };
}
