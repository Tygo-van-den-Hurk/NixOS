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
  config.programs.${program}.settings.mainBar = mkIf cfg.enable {
    pulseaudio = {
      scroll-step = 1;

      format = "{volume}% {icon} {format_source}";
      format-bluetooth = "{volume}% {icon} {format_source}";
      format-bluetooth-muted = " {icon} {format_source}";
      format-muted = "muted  {format_source}";
      format-source = "{volume}% ";
      format-source-muted = "muted ";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [
          ""
          ""
          ""
        ];
      };

      on-click =
        with pkgs;
        getExe (
          writeShellScriptBin "${program}-pulseaudio-on-click" ''
            exec > >(systemd-cat -t '${program}-pulseaudio-on-click') 2>&1
            ${getExe pavucontrol}
          ''
        );
    };
  };
}
