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
  config.programs.${program}.settings."nodejs" = mkIf cfg.enable {
    disabled = false;
    format = "using [$symbol $version]($style)";
    style = "bold green";
    version_format = "v\${raw}";
    symbol = "NodeJS";
    detect_folders = [ "node_modules" ];
    not_capable_style = "bold red";

    detect_extensions = [
      "js"
      "mjs"
      "cjs"
      "ts"
      "mts"
      "cts"
    ];

    detect_files = [
      "package.json"
      ".node-version"
      ".nvmrc"
      "!bunfig.toml"
      "!bun.lock"
      "!bun.lockb"
    ];
  };
}
