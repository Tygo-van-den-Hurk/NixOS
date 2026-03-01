{
  lib,
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
    network = {
      tooltip = true;
      rotate = 0;
      interval = 2;

      format-ethernet = " ";
      format-linked = " {ifname} (No IP)";
      format-disconnected = "󰖪 ";

      tooltip-format-disconnected = "Disconnected";
      tooltip-format = ''
        Network: <b>{essid}</b>
        Signal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>
        Frequency: <b>{frequency}MHz</b>
        Interface: <b>{ifname}</b>
      '';
    };
  };
}
