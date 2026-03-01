{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  type = "wm";
  category = "shortcuts";
in
{
  config.${namespace}.${type}.${category} =
    with builtins;
    let
      workspaceNames = attrNames config.${namespace}.${type}.workspaces;
      filterWorkspaces = filter (name: config.${namespace}.${type}.workspaces.${name}.enable);
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

      moveFocusToWorkspaceUsingSnowflake = listToAttrs (
        genList (i: {
          name = "moving focus to workspace ${toString (i + 1)} using snowflake";
          value = {
            control = true;
            option = true;
            super = true;
            shift = true;
            key = toString (i + 1);
            action.hyprland = "workspace, ${toString (i + 1)}";
            action.i3 = "workspace $ws${toString (i + 1)}";
          };
        }) amountOfWorkspaces
      );

      chars."1" = "a";
      chars."2" = "b";
      chars."3" = "c";
      chars."4" = "d";
      chars."5" = "e";
      chars."6" = "f";
      chars."7" = "g";
      chars."8" = "h";
      chars."9" = "i";
      chars."0" = "j";

      moveWindowToWorkspaceUsingSnowflake = listToAttrs (
        genList (i: {
          name = "moving window to workspace ${toString (i + 1)} using snowflake";
          value = {
            control = true;
            option = true;
            super = true;
            shift = true;
            key = chars.${toString (i + 1)};
            action.hyprland = "moveToWorkspace, ${toString (i + 1)}";
            action.i3 = "move container to workspace number $ws${toString (i + 1)}; workspace $ws${toString (i + 1)}";
          };
        }) amountOfWorkspaces
      );

      result =
        moveWindowToWorkspace
        // moveFocusToWorkspace
        // moveFocusToWorkspaceUsingSnowflake
        // moveWindowToWorkspaceUsingSnowflake;

    in
    if amountOfWorkspaces > 10 then throw "Snowflake can only handle up to 10 workspaces." else result;
}
