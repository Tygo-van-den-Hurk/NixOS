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
  config.programs.${program}.settings = mkIf cfg.enable {
    mainBar."systemd-failed-units" = {
      hide-on-ok = true;
      format = " {nr_failed}";
      format-ok = "";
      system = true;
      user = true;
      tooltip = true;
      tooltip-format-ok = "All systemd units are running successfully.";
      tooltip-format = strings.trim ''
        <b>Number of Failed SystemD Units</b>
        <b>System</b>: {nr_failed_system}
        <b>User</b>: {nr_failed_user}
        <b>Total</b>: {nr_failed}
      '';
    };
  };
}
