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
