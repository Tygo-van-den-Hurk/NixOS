{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "ricing";
  program = "onefetch";
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
    shellAliases."gitfetch" = program;
    packages = with pkgs; [
      onefetch
    ];
  };
}
