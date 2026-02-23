{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "miscellaneous";
  program = "starship";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  config.programs.${program}.settings."character" = mkIf cfg.enable {
    format = "$symbol";
    success_symbol = "[\\$](bold green)";
    error_symbol = "[\\$](bold red)";
    vimcmd_symbol = "[\\$](bold green)";
    vimcmd_visual_symbol = "[\\$](bold yellow)";
    vimcmd_replace_symbol = "[\\$](bold purple)";
    vimcmd_replace_one_symbol = "[\\$](bold purple)";
    disabled = false;
  };
}
