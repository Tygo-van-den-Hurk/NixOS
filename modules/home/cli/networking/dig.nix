{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "cli";
  category = "networking";
  program = "dig";
  cfg = config.${namespace}.${module}.${category}.${program};
in
{
  options.${namespace}.${module}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${module}.${category}.enable;
      type = bool;
    };
  };

  config.home = mkIf cfg.enable {
    packages = [ pkgs.${program} ];
  };
}
