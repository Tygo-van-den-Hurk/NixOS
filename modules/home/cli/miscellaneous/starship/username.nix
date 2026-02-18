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
  config.programs.${program}.settings."username" = mkIf cfg.enable {
    disabled = false;
    detect_env_vars = [ ];
    format = "[$user]($style)";
    style_root = "red bold";
    style_user = "green bold";
    show_always = true;
  };
}
