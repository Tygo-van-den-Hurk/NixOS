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
    window_rule =
      let
        escapeRegex =
          str:
          builtins.replaceStrings
            [
              "."
              "+"
              "*"
              "?"
              "^"
              "$"
              "("
              ")"
              "["
              "]"
              "{"
              "}"
              "|"
              "\\"
            ]
            [
              "\\."
              "\\+"
              "\\*"
              "\\?"
              "\\^"
              "\\$"
              "\\("
              "\\)"
              "\\["
              "\\]"
              "\\{"
              "\\}"
              "\\|"
              "\\\\"
            ]
            str;

        indexWorkspace =
          workspace:
          let
            cfg = config.${namespace}.${category}.workspaces;
          in
          cfg.${workspace}.order or (throw "The workspace named '${workspace}' does not exist.");

        assignmentToString =
          _name: instance:
          if !instance.enable then
            null

          else if instance ? raw then
            instance.raw.${program}

          else if instance ? class then
            {
              workspace = toString (indexWorkspace instance.workspace);
              match.class = "^${if instance.case_insensitive then "(?i)" else ""}${escapeRegex instance.class}$";
            }

          else
            throw "none implemented assignment rule: ${builtins.toJSON instance}";
      in
      mapAttrsToList assignmentToString config.${namespace}.${category}.assignments;
  };
}
