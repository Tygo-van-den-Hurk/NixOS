{
  lib,
  config,
  ...
}:
with lib;
let
  type = "wm";
  program = "hyprpaper";
  cfg = config.${type}.${program};
in
{
  options.${type}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${type}.hyprland.enable;
      type = bool;
    };
  };

  config.services.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    settings = { };
  };
}
