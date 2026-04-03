{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  type = "gui";
  category = "editors";
  program = "vscode";
  profile = "default";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  config.programs.${program}.profiles.${profile} = mkIf cfg.enable {
    keybindings = [
      {
        key = "ctrl+alt+up";
        command = "editor.action.insertCursorAbove";
        when = "editorTextFocus";
      }
      {
        key = "ctrl+alt+down";
        command = "editor.action.insertCursorBelow";
        when = "editorTextFocus";
      }
    ];
  };
}
