{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  type = "gui";
  category = "browsers";
  program = "firefox";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  config = mkIf (cfg.enable && config ? stylix) {
    stylix.targets.firefox.profileNames = [
      "main"
    ];
  };
}
