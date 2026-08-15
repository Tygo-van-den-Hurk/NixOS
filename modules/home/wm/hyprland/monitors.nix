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
    monitor =
      let
        inherit (config.${namespace}.${category}) monitors;
        monitorToConfig = _description: instance: {
          _args = [
            {
              inherit (instance) scale;
              output = instance.adapter;
              disabled = if !instance.enable then true else false;

              mode =
                let
                  horizontal = toString instance.resolution.horizontal;
                  vertical = toString instance.resolution.vertical;
                  refresh-rate = toString instance.refresh-rate;
                in
                "${horizontal}x${vertical}@${refresh-rate}";

              position =
                if instance.position.horizontal == null || instance.position.vertical == null then
                  "auto"
                else
                  let
                    horizontal = toString instance.position.horizontal;
                    vertical = toString instance.position.vertical;
                  in
                  "${horizontal}x${vertical}";
            }
          ];
        };
      in
      (mapAttrsToList monitorToConfig monitors)
      ++ [
        {
          _args = [
            {
              output = "";
              mode = "preferred";
              position = "auto";
              scale = 1;
            }
          ];
        }
      ];
  };
}
