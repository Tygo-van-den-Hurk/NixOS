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
    workspace =
      let
        workspaceToString =
          description: instance:
          if !instance.enable then
            "${adapter}, disable"
          else
            let
              order = toString instance.order;
              name = "defaultName:${instance.name}";
              persistent = "persistent:true";
              primary = "default:${if instance.primary or false then "true" else "false"}";
              monitor = "${if instance.display != null then "monitor:${toString instance.display}" else ""}";
            in
            "${order}, ${name}, ${primary}, ${persistent}, ${monitor} # ${description}";
      in
      mapAttrsToList workspaceToString config.${category}.workspaces;
  };
}
