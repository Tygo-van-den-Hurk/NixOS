{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "editors";
  program = "glow";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  options.${namespace}.${type}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.${category}.enable;
      type = bool;
    };
  };

  config.home = mkIf cfg.enable {
    packages = [ pkgs.glow ];
  };

  config.xdg.configFile = mkIf cfg.enable {
    "glow/glow.yml".text = builtins.toJSON {
      style = "auto";
      mouse = true;
      pager = false;
      width = 80;
      all = false;
    };
  };
}
