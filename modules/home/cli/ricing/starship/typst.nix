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
  config.programs.${program}.settings."typst" = mkIf cfg.enable {
    disabled = false;
    format = "via [$symbol($version )]($style)";
    version_format = "v\${raw}";
    symbol = "t ";
    style = "bold #0093A7";
    detect_extensions = [ "typ" ];
    detect_files = [ "template.typ" ];
    detect_folders = [ ];
  };
}
