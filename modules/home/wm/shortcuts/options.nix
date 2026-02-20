{
  lib,
  config,
  ...
}:
with lib;
let
  type = "wm";
  category = "shortcuts";
  cfg = config.${type}.${category};
in
{
  options.${type} = with types; {
    ${category} = mkOption {
      description = "Set of shortcuts each window manager has.";

      default = { };
      example = literalExample { };

      type = attrsOf (
        submodule (_: {
          options = {
            enable = mkOption {
              description = "Whether this shortcut is enabled and will execute.";
              type = bool;
              default = true;
            };

            key = mkOption {
              description = "The key that must be pressed to finalise the shortcut.";
              default = false;
              type =
                let

                  functionKeys = "F[1-9][0-4]?";

                  letters = "[a-z]";

                  numbers = "[0-9]";

                  movement = "Up|Down|Left|Right|Home|End|PageUp|PageDown";

                  special =
                    let
                      audio = "XF86AudioRaiseVolume|XF86AudioLowerVolume|XF86AudioMute|XF86AudioMicMute";
                      brightness = "XF86MonBrightnessUp|XF86MonBrightnessDown";
                    in
                    "${audio}|${brightness}";

                  misc = "Escape|Enter|Tab|Space";
                in
                strMatching "^(${functionKeys}|${letters}|${numbers}|${movement}|${special}|${misc})$";
            };

            control = mkOption {
              description = "Whether control is held for this shortcut";
              type = bool;
              default = false;
            };

            option = mkOption {
              description = "Whether option/alt is held for this shortcut";
              type = bool;
              default = false;
            };

            shift = mkOption {
              description = "Whether the shift is held for this shortcut";
              type = bool;
              default = false;
            };

            super = mkOption {
              description = "Whether the super/windows key is held for this shortcut";
              type = types.bool;
              default = false;
            };

            action = mkOption {
              description = "What this shortcut must do.";
              type = oneOf [
                # allow for making different versions based on `type` key:
                (addCheck (submodule {
                  options = {
                    # type = mkOption {
                    #   description = "The type of action that must happen when the key combination is pressed.";
                    #   type = strMatching "^execute-match$";
                    # };
                    hyprland = mkOption {
                      description = "Command to execute on Hyprland";
                      type = str;
                    };
                    i3 = mkOption {
                      description = "Command to execute on i3";
                      type = str;
                    };
                  };
                }) (_: true)) # (module: module.type == "execute-match")
              ];
            };
          };
        })
      );
    };
  };

  config.xdg.configFile."${type}/${category}.json".text = builtins.toJSON cfg;
}
