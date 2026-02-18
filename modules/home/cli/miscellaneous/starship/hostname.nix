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
  config.programs.${program}.settings."hostname" = mkIf cfg.enable {
    disabled = false;
    ssh_only = false;
    ssh_symbol = " \\([ssh](green bold)\\)";
    trim_at = ".";
    detect_env_vars = [ ];
    format = "[$hostname]($style)$ssh_symbol";
    style = "green bold";
  };
}
