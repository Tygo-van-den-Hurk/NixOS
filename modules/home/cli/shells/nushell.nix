{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  program = "nushell";
  category = "shells";
  type = "cli";
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

  config.programs.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    settings = {
      history.format = mkDefault "sqlite";
      show_banner = mkDefault false;
    };
  };
}
