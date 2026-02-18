{
  lib,
  config,
  ...
}:
with lib;
let
  program = "nushell";
  category = "shells";
  type = "cli";
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

  config.programs.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    settings = {
      history.format = mkDefault "sqlite";
      show_banner = mkDefault false;
    };
  };
}
