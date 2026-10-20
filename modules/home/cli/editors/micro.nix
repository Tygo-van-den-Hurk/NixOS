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

    package = mkOption {
      description = "The wrapper to execute instead.";
      default = pkgs.micro-full;
      type = package;
    };

    mkDefault = mkOption {
      description = "Whether to make ${program} the default program to open its file type.";
      default = false;
      type = bool;
    };
  };

  config.programs.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    inherit (cfg) package;
  };

  config.home.sessionVariables = mkIf cfg.mkDefault {
    EDITOR = mkDefault (getExe cfg.package);
  };
}
