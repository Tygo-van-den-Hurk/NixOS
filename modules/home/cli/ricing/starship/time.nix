{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "ricing";
  program = "starship";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  config.programs.${program}.settings."time" = mkIf cfg.enable {
    format = "\\[[$time]($style)\\]";
    style = "bold yellow";
    use_12hr = false;
    disabled = false;
    utc_time_offset = "local";
    time_range = "-";
  };
}
