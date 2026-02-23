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
  program = "micro";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  options.${namespace}.${type}.${category}.${program} = with types; {

    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.${category}.enable;
      type = bool;
    };

    mkDefault = mkOption {
      description = "Whether to make ${program} the default program to open its file type.";
      default = cfg.enable;
      type = bool;
    };
  };

  config.programs.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    package = pkgs.micro-full;
    settings = mkDefault { };
  };

  config.home.sessionVariables = mkIf cfg.mkDefault {
    EDITOR = mkDefault (getExe pkgs.${program});
  };
}
