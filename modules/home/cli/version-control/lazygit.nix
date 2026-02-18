{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  type = "cli";
  category = "version-control";
  program = "lazygit";
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
    settings = { };
  };

  config.home.shellAliases = mkIf cfg.enable {
    lg = mkDefault (getExe pkgs.${program});
  };
}
