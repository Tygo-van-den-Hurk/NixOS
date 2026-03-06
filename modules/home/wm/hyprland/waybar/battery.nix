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
  config.programs.${program}.settings = mkIf cfg.enable rec {

    mainBar.battery.states = {
      full = 100;
      good = 85;
      warning = 15;
      critical = 5;
    };

    mainBar.battery = {
      format = "{icon} {capacity}%";
      format-full = "{icon} {capacity}%";
      format-charging = "󰂄 {capacity}%";
      format-plugged = "󰂃 {capacity}%";
      format-alt = "󰂑 {icon}";
      format-icons = [
        "󰂎"
        "󰁺"
        "󰁻"
        "󰁼"
        "󰁽"
        "󰁾"
        "󰁿"
        "󰂀"
        "󰂁"
        "󰂂"
        "󰁹"
      ];
    };

    mainBar.battery = {
      tooltip = true;
      tooltip-format = strings.trim ''
        <b>Capacity</b>: {capacity}
        <b>Power</b>: {power}
        <b>Time</b>: {timeTo}
        <b>Cycles</b>: {cycles}
        <b>Health</b>: {health}
      '';
    };
  };
}
