{
  lib,
  config,
  ...
}:
with lib;
let
  type = "wm";
  program = "hyprland";
  cfg = config.${type}.${program};
in
{
  options.${type}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${type}.enable;
      type = bool;
    };
  };

  config.wayland.windowManager.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    settings = {

    };
  };
}
