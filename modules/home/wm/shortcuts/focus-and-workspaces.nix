{
  config,
  lib,
  ...
}:
with lib;
let
  type = "wm";
  category = "shortcuts";
in
{
  config.${type}.${category} =
    with builtins;
    let
      workspaceNames = attrNames config.${type}.workspaces;
      filterWorkspaces = filter (name: config.${type}.workspaces.${name}.enable);
      enabledWorkspaces = filterWorkspaces workspaceNames;
      amountOfWorkspaces = length enabledWorkspaces;

      moveFocusToWorkspace = listToAttrs (
        genList (i: {
          name = "moving focus to workspace ${toString (i + 1)}";
          value = {
            super = true;
            key = toString (i + 1);
            action.hyprland = "workspace, ${toString (i + 1)}";
            action.i3 = "workspace $ws${toString (i + 1)}";
          };
        }) amountOfWorkspaces
      );

      moveWindowToWorkspace = listToAttrs (
        genList (i: {
          name = "moving window to workspace ${toString (i + 1)}";
          value = {
            super = true;
            shift = true;
            key = toString (i + 1);
            action.hyprland = "moveToWorkspace, ${toString (i + 1)}";
            action.i3 = "move container to workspace number $ws${toString (i + 1)}; workspace $ws${toString (i + 1)}";
          };
        }) amountOfWorkspaces
      );

    in
    moveWindowToWorkspace // moveFocusToWorkspace;
}
