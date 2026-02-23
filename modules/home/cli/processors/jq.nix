{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "processors";
  program = "jq";
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
    colors = {
      arrays = mkDefault "1;37"; # white and bright
      objects = mkDefault "1;37"; # white and bright
      objectKeys = mkDefault "0;36"; # cyan and normal
      numbers = mkDefault "0;32"; # green and normal
      strings = mkDefault "0;33"; # yellow and normal
      false = mkDefault "0;34"; # blue and normal
      true = mkDefault "0;34"; # blue and normal
      null = mkDefault "0;34"; # blue and normal
    };
  };
}
