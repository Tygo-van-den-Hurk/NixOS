{
  pkgs,
  lib,
  config,
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

    # open applications

    "spotlight" = {
      control = true;
      key = "Space";

      # TODO: fill in for hyprland. Find equivalent program.
      action.hyprland = "exec, ${getExe (
        writeShellScriptBin "spotlight-hyprland" ''
          exit 1
        ''
      )}";

      # TODO: grab font size from i3 config: `--font '$fontFamily-$fontSize'`
      action.i3 = "exec ${getExe (
        writeShellScriptBin "spotlight-i3" ''
          ${dmenu-rs-enable-plugins}/bin/dmenu_run --fast \
            --fn '-${config.stylix.fonts.serif.name or "OpenDyslexicM Nerd Font Mono"}-9' \
            -nf '#${config.stylix.base16Scheme.base05 or "8f8f8f"}' \
            -sf '#${config.stylix.base16Scheme.base04 or "ffffff"}' \
            -nb '#${config.stylix.base16Scheme.base00 or "000000"}' \
            -sb '#${config.stylix.base16Scheme.base02 or "000000"}' \
            --lines 10 --insensitive --prompt 'search:' --autoselect \
            "$@"
        ''
      )}";
    };

    # open a new terminal

    "open a new terminal" = {
      super = true;
      key = "Enter";
      action.hyprland = "exec, ${
        getExe (
          writeShellScriptBin "open-new-terminal-hyprland" /* SHELL */ ''
            if [ -z "$TERMINAL" ]; then
              exec "$TERMINAL"
            else
              echo "the TERMINAL env var is not defined."
              exit 1
            fi
          ''
        )
      }";

      action.i3 = "exec ${
        getExe (
          writeShellScriptBin "open-new-terminal-i3" /* SHELL */ ''
            if [ -z "$TERMINAL" ]; then
              exec "$TERMINAL"
            else
              echo "the TERMINAL env var is not defined."
              exit 1
            fi
          ''
        )
      }";
    };

    # Closing applications

    "closing all instances of an application" = {
      control = true;
      key = "q";
      action.i3 = "[class=__focused__] kill";
      action.hyprland = "killactive";
    };

    "closing a window of an application" = {
      control = true;
      shift = true;
      key = "q";
      action.i3 = "kill";
      action.hyprland = "exec, ${
        getExe (
          writeShellScriptBin "close-all-windows" /* SHELL */ ''
            class=$(hyprctl activewindow -j | jq -r .class)
            hyprctl clients -j | jq -r ".[] | select(.class==\"$class\") | .address" | \
            while read addr; do
              hyprctl dispatch closewindow address:$addr
            done
          ''
        )
      }";
    };

    "toggle full screen" = {
      super = true;
      control = true;
      key = "f";
      action.hyprland = "fullscreen, 0";
      action.i3 = "fullscreen toggle";
    };

  };
}
