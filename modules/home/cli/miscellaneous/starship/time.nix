{
  lib,
  config,
  ...
}:
with lib;
let
  type = "cli";
  category = "miscellaneous";
  program = "starship";
  cfg = config.${type}.${category}.${program};
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
