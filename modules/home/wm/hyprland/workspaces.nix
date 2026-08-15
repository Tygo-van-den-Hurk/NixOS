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
    workspace_rule =
      let
        inherit (config.${namespace}.${category}) workspaces;
        enabledWorkspaces = filterAttrs (_description: instance: instance.enable) workspaces;
        workspaceToConfig = _description: instance: {
          _args = [
            {
              workspace = "${toString instance.order}";
              default_name = "${instance.name}";
              monitor = "${toString instance.display}";
              persistent = true;
              default = instance.primary or false;
            }
          ];
        };
      in
      mapAttrsToList workspaceToConfig enabledWorkspaces;
  };
}
