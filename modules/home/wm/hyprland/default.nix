{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "wm";
  program = "hyprland";
  cfg = config.${namespace}.${type}.${program};
in
{
  options.${namespace}.${type}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.enable;
      type = bool;
    };
  };

  config.wayland.windowManager.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    settings = {

    };
  };
}
