{
  inputs,
  config,
  lib,
  ...
}:
with lib;
let
  type = "gui";
  category = "browsers";
  program = "firefox";
  cfg = config.${type}.${category}.${program};
in
{
  config= mkIf (cfg.enable && config ? stylix) {
    stylix.targets.firefox.profileNames = [
      "main"
    ];
  }; 
}
