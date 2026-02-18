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
  config.programs.${program}.settings."rust" = mkIf cfg.enable {
    disabled = false;
    format = "using [$symbol $version]($style)";
    version_format = "v\${raw}";
    symbol = "Rust ";
    style = "bold red";
    detect_extensions = [ "rs" ];
    detect_files = [ "Cargo.toml" ];
    detect_folders = [ ];
  };
}
