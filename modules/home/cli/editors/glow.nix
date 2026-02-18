{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  type = "cli";
  category = "editors";
  program = "glow";
  cfg = config.${type}.${category}.${program};
in
{
  options.${type}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${type}.${category}.enable;
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
