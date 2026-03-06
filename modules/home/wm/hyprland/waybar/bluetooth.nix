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
  config.programs.${program}.settings.mainBar = mkIf cfg.enable rec {

    bluetooth = {
      format-no-controller = ""; # hide module
      format-disabled = "<span size='large'>󰂲</span>";
      format-off = "<span size='large'></span>";
      format-on = "<span size='large'></span>";
      format-connected = "<span size='large'>󰂳</span>";

      tooltip-format = strings.trim ''
        <b>Controller Alias</b>: {controller_alias}
        <b>Controller Address</b>: {controller_address}
      '';

      tooltip-format-connected = ''
        ${bluetooth.tooltip-format}
        <b>Devices</b>:
        {device_enumerate}
      '';

      tooltip-format-enumerate-connected = ''
        <b>Device Alias</b>: {device_alias}
        <b>Device Address</b>: {device_address}
      '';
    };
  };
}
