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
    #  Enables support for special function keys:
    #
    #  - Volume:      XF86AudioRaiseVolume, XF86AudioLowerVolume, XF86AudioMute, XF86AudioMicMute
    #  - Brightness:  XF86MonBrightnessUp, XF86MonBrightnessDown
    #

    # Volume

    "increase volume" = {
      key = "XF86AudioRaiseVolume";

      action.hyprland = "exec, ${getExe (
        writeShellScriptBin "increase-volume-hyprland" ''
          current_volume="$(pactl get-sink-volume "@DEFAULT_SINK@" | grep -oP '\d+%' | head -1 | tr -d '%')"

          new_volume=$((current_volume + 5))

          if [ "$new_volume" -gt 100 ]; then
            new_volume=100
          fi

          pactl set-sink-volume "@DEFAULT_SINK@" "''${new_volume}%"
        ''
      )}";

      action.i3 = "exec --no-startup-id ${getExe (
        writeShellScriptBin "increase-volume-i3" ''
          current_volume="$(pactl get-sink-volume "@DEFAULT_SINK@" | grep -oP '\d+%' | head -1 | tr -d '%')"

          new_volume=$((current_volume + 5))

          if [ "$new_volume" -gt 100 ]; then
            new_volume=100
          fi

          pactl set-sink-volume "@DEFAULT_SINK@" "''${new_volume}%"
        ''
      )}";
    };

    "decrease volume" = {
      key = "XF86AudioLowerVolume";

      action.hyprland = "exec, ${getExe (
        writeShellScriptBin "decrease-volume-hyprland" ''
          pactl set-sink-volume "@DEFAULT_SINK@" -5%
        ''
      )}";

      action.i3 = "exec --no-startup-id ${getExe (
        writeShellScriptBin "decrease-volume-i3" ''
          pactl set-sink-volume "@DEFAULT_SINK@" -5%
        ''
      )}";
    };

    "toggle mute volume" = {
      key = "XF86AudioMute";

      action.hyprland = "exec, ${getExe (
        writeShellScriptBin "toggle-mute-volume-i3" ''
          pactl set-sink-mute "@DEFAULT_SINK@" toggle
        ''
      )}";

      action.i3 = "exec --no-startup-id ${getExe (
        writeShellScriptBin "toggle-mute-volume-i3" ''
          pactl set-sink-mute "@DEFAULT_SINK@" toggle
        ''
      )}";
    };

    "toggle mute microphone" = {
      key = "XF86AudioMicMute";

      action.hyprland = "exec, ${getExe (
        writeShellScriptBin "toggle-mute-volume-i3" ''
          pactl set-sink-mute "@DEFAULT_SINK@" toggle
        ''
      )}";

      action.i3 = "exec --no-startup-id ${getExe (
        writeShellScriptBin "toggle-mute-microphone-i3" ''
          pactl set-sink-mute "@DEFAULT_SOURCE@" toggle
        ''
      )}";
    };

    # Brightness

    "increase brightness" = {
      key = "XF86MonBrightnessUp";

      action.hyprland = "exec, ${getExe (
        writeShellScriptBin "increase-brightness-hyprland" ''
          brightnessctl set +5%
        ''
      )}";

      action.i3 = "exec --no-startup-id ${getExe (
        writeShellScriptBin "increase-brightness-i3" ''
          brightnessctl set +5%
        ''
      )}";
    };

    "decrease brightness" = {
      key = "XF86MonBrightnessDown";

      action.hyprland = "exec, ${getExe (
        writeShellScriptBin "decrease-brightness-hyprland" ''
          brightnessctl set 5%-
        ''
      )}";

      action.i3 = "exec --no-startup-id ${getExe (
        writeShellScriptBin "decrease-brightness-i3" ''
          brightnessctl set 5%-
        ''
      )}";
    };

  };
}
