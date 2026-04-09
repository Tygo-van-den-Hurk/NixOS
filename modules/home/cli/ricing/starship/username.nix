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
  config.programs.${program}.settings."username" = mkIf cfg.enable {
    disabled = false;
    detect_env_vars = [ ];
    format = "[$user]($style)";
    style_root = "red bold";
    style_user = "green bold";
    show_always = true;
  };
}
