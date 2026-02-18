{
  lib,
  config,
  ...
}:
with lib;
let
  category = "wm";
  program = "hyprland";
  cfg = config.${category}.${program};
in
{
  config.wayland.windowManager.${program}.settings = mkIf cfg.enable {
    monitor =
      let
        monitorToString =
          name: instance:
          if !instance.enable then
            "${adapter}, disable"
          else
            let
              resolution =
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

              scale = toString instance.scale;
              adapter = toString instance.adapter;
            in
            "${adapter}, ${resolution}, ${position}, ${scale} # ${name}";
      in
      (mapAttrsToList monitorToString config.${category}.monitors)
      ++ [ ", preferred, auto, 1 # Catch all" ];
  };
}
