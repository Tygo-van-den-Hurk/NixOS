{
  lib,
  config,
  ...
}:
with lib;
let
  type = "gui";
  category = "terminals";
  program = "alacritty";
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
      general.live_config_reload = mkDefault true;
      window = {
        dynamic_title = mkDefault true;
        padding.x = mkDefault 0;
        padding.y = mkDefault 0;
        blur = mkDefault true;
      };
    };
  };
}
