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
  config.programs.${program}.settings."c" = mkIf cfg.enable {
    disabled = false;
    format = "using [$name]($style) \\([$symbol]($style)\\) on [$version]($style)";
    version_format = "v\${raw}";
    style = "149 bold";
    symbol = "C";
    detect_files = [ ];
    detect_folders = [ ];
    detect_extensions = [ "c" ];
    commands = [
      [
        "cc"
        "--version"
      ]
      [
        "gcc"
        "--version"
      ]
      [
        "clang"
        "--version"
      ]
    ];
  };
}
