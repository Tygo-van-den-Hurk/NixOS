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
    
    settings.env = [ "XCURSOR_SIZE, 24" ];
    settings.gesture = [ "4, horizontal, workspace" ];
    
    settings.bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
    
    settings.input = {
      follow_mouse = mkDefault 1;
      sensitivity = mkDefault 0;
      touchpad = {
        natural_scroll = mkDefault true;
        clickfinger_behavior = mkDefault false;
        tap-to-click = mkDefault true;
      };
    };
  };
}
