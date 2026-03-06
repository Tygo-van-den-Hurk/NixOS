{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "wm";
  program = "waybar";
  cfg = config.${namespace}.${type}.${program};
in
{
  config.programs.${program}.settings = mkIf cfg.enable rec {

    mainBar."pulseaudio#volume" = {
      scroll-step = 0.5;
      reverse-scrolling = true;

      format = "{icon} {volume}%";
      format-bluetooth = mainBar."pulseaudio#volume".format;
      format-muted = "<span size='large'>󰖁</span> {volume}%";
      format-bluetooth-muted = mainBar."pulseaudio#volume".format-muted;
      format-icons = {
        headphone = "";
        hands-free = "󰤽";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [
          # Nerd fonts somehow failed to align
          # all of these icons, even though they
          # come from the same icon set...
          # "<span size='xx-large'></span>"
          # "<span size='large'>󰖀</span>"
          # "<span size='x-large'>󰕾</span>"
          "<span size='x-large'></span>"
        ];
      };

      tooltip = true;
      tooltip-format = strings.trim ''
        <b>Volume</b>: {volume}%
        <b>Description</b>: {desc}
      '';

      on-click =
        with pkgs;
        getExe (
          writeShellScriptBin "${program}-pulseaudio-on-click" ''
            exec > >(systemd-cat -t '${program}-pulseaudio-on-click') 2>&1
            ${getExe pavucontrol}
          ''
        );

      on-click-right =
        with pkgs;
        getExe (
          writeShellScriptBin "${program}-pulseaudio-microphone-on-right-click" ''
            exec > >(systemd-cat -t '${program}-pulseaudio-microphone-on-right-click') 2>&1
            ${pulseaudioFull}/bin/pactl set-sink-mute "@DEFAULT_SINK@" toggle
          ''
        );
    };

    mainBar."pulseaudio#microphone" = {
      format = "{format_source}";
      format-source = "<span size='large'>󰍬</span>";
      format-source-muted = "<span size='x-large'>󰍭</span>";

      inherit (mainBar."pulseaudio#volume") on-click;
      on-click-right =
        with pkgs;
        getExe (
          writeShellScriptBin "${program}-pulseaudio-microphone-on-right-click" ''
            exec > >(systemd-cat -t '${program}-pulseaudio-microphone-on-right-click') 2>&1
            ${pulseaudioFull}/bin/pactl set-source-mute "@DEFAULT_SOURCE@" toggle
          ''
        );

      tooltip = false;
    };
  };
}
