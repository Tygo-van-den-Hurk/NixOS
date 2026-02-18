{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  type = "cli";
  category = "miscellaneous";
  program = "onefetch";
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
    packages = [ pkgs.onefetch ];
    shellAliases = {
      "gitfetch" = program;
    };
  };
}
