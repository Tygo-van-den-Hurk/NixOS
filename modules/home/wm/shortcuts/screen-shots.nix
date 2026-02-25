{
  pkgs,
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
  config.${namespace}.${type}.${category} = with pkgs; {
    #
    #  Screen shot keyboard shortcuts follow the MacOS key bindings:
    #
    #  - tertiary modifier + shift + 3: full screen on your desktop
    #  - tertiary modifier + shift + 4: selection on your desktop
    #  - tertiary modifier + shift + 5: options on your desktop
    #
    #  Add the `secondary modifier` for going to clipboard:
    #
    #  - tertiary modifier + secondary modifier + shift + 3: putting full screen on your clipboard
    #  - tertiary modifier + secondary modifier + shift + 4: putting selection on your clipboard
    #  - tertiary modifier + secondary modifier + shift + 5: putting options on your clipboard
    #

    # screen shots putting it on the desktop
    "screenshot-entire-screen" = {
      key = "3";
      shift = true;
      control = true;

      action.hyprland = "exec, ${
        getExe (
          writeShellScriptBin "screenshot-entire-screen-hyprland" /* SHELL */ ''
            exec > >(systemd-cat -t screenshot-entire-screen-hyprland) 2>&1
            echo "ERROR: no such program installed yet.."
            exit 1 # TODO: fill in for hyprland
          ''
        )
      }";

      action.i3 = "exec --no-startup-id ${
        getExe (
          writeShellScriptBin "screenshot-entire-screen-i3" /* SHELL */ ''
            exec > >(systemd-cat -t screenshot-entire-screen-i3) 2>&1
            ${getExe flameshot} screen --path '~/Desktop/$(date +%Y-%m-%d_%H-%M-%S).png'
            ${getExe' mpg123 "mpg123"} -k 27 ${./screen-shot.mp3} -v
          ''
        )
      }";
    };

    "screenshot-select-section" = {
      key = "4";
      shift = true;
      control = true;

      action.hyprland = "exec, ${
        getExe (
          writeShellScriptBin "screenshot-select-section-hyprland" /* SHELL */ ''
            exec > >(systemd-cat -t screenshot-select-section-hyprland) 2>&1
            echo "ERROR: no such program installed yet.."
            exit 1 # TODO: fill in for hyprland
          ''
        )
      }";

      action.i3 = "exec --no-startup-id ${
        getExe (
          writeShellScriptBin "screenshot-select-section-i3" /* SHELL */ ''
            exec > >(systemd-cat -t screenshot-select-section-i3) 2>&1
            ${getExe flameshot} gui --accept-on-select --path '~/Desktop/$(date +%Y-%m-%d_%H-%M-%S).png'
            ${getExe' mpg123 "mpg123"} -k 27 ${./screen-shot.mp3} -v
          ''
        )
      }";
    };

    "screenshot-special" = {
      key = "5";
      shift = true;
      control = true;

      action.hyprland = "exec, ${
        getExe (
          writeShellScriptBin "screenshot-special-hyprland" /* SHELL */ ''
            exec > >(systemd-cat -t screenshot-special-hyprland) 2>&1
            echo "ERROR: no such program installed yet.."
            exit 1 # TODO: fill in for hyprland
          ''
        )
      }";

      action.i3 = "exec --no-startup-id ${
        getExe (
          writeShellScriptBin "screenshot-special-i3" /* SHELL */ ''
            exec > >(systemd-cat -t screenshot-special-i3) 2>&1
            ${getExe flameshot} gui --path '~/Desktop/$(date +%Y-%m-%d_%H-%M-%S).png'
            ${getExe' mpg123 "mpg123"} -k 27 ${./screen-shot.mp3} -v
          ''
        )
      }";
    };

    # screen shots putting it on your clipboard

    "screenshot-entire-screen-to-clipboard" = {
      key = "3";
      shift = true;
      control = true;
      super = true;

      action.hyprland = "exec, ${
        getExe (
          writeShellScriptBin "screenshot-entire-screen-to-clipboard-hyprland" /* SHELL */ ''
            exec > >(systemd-cat -t screenshot-entire-screen-to-clipboard-hyprland) 2>&1
            echo "ERROR: no such program installed yet.."
            exit 1 # TODO: fill in for hyprland
          ''
        )
      }";

      action.i3 = "exec --no-startup-id ${
        getExe (
          writeShellScriptBin "screenshot-entire-screen-to-clipboard-i3" /* SHELL */ ''
            exec > >(systemd-cat -t screenshot-entire-screen-to-clipboard-i3) 2>&1
            ${getExe flameshot} screen --raw | xclip -selection clipboard -t image/png
            ${getExe' mpg123 "mpg123"} -k 27 ${./screen-shot.mp3} -v
          ''
        )
      }";
    };

    "screenshot-select-section-to-clipboard" = {
      key = "4";
      shift = true;
      control = true;
      super = true;

      action.hyprland = "exec, ${
        getExe (
          writeShellScriptBin "screenshot-select-section-to-clipboard-hyprland" /* SHELL */ ''
            exec > >(systemd-cat -t screenshot-select-section-to-clipboard-hyprland) 2>&1
            echo "ERROR: no such program installed yet.."
            exit 1 # TODO: fill in for hyprland
          ''
        )
      }";

      action.i3 = "exec --no-startup-id ${
        getExe (
          writeShellScriptBin "screenshot-select-section-to-clipboard-i3" /* SHELL */ ''
            exec > >(systemd-cat -t screenshot-select-section-to-clipboard-i3) 2>&1
            ${getExe flameshot} gui --raw --accept-on-select | xclip -selection clipboard -t image/png
            ${getExe' mpg123 "mpg123"} -k 27 ${./screen-shot.mp3} -v
          ''
        )
      }";
    };

    "screenshot-special-to-clipboard" = {
      key = "5";
      shift = true;
      control = true;
      super = true;

      action.hyprland = "exec, ${
        getExe (
          writeShellScriptBin "screenshot-special-to-clipboard-hyprland" /* SHELL */ ''
            exec > >(systemd-cat -t screenshot-special-to-clipboard-hyprland) 2>&1
            echo "ERROR: no such program installed yet.."
            exit 1 # TODO: fill in for hyprland
          ''
        )
      }";

      action.i3 = "exec --no-startup-id ${
        getExe (
          writeShellScriptBin "screenshot-special-to-clipboard-i3" /* SHELL */ ''
            exec > >(systemd-cat -t screenshot-special-to-clipboard-i3) 2>&1
            ${getExe flameshot} gui --raw | xclip -selection clipboard -t image/png
            ${getExe' mpg123 "mpg123"} -k 27 ${./screen-shot.mp3} -v
          ''
        )
      }";
    };
  };
}
