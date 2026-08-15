{
  lib,
  pkgs,
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
    configType = mkDefault "lua";
    enable = mkDefault true;

    settings.on = [
      {
        _args = with pkgs; [
          "hyprland.start"
          (generators.mkLuaInline /* Lua */ ''
            function()
              hl.dsp.exec_cmd("${getExe (
                writeShellScriptBin "dex-xdg-autostart-hyprland" ''
                  exec > >(systemd-cat -t dex-xdg-autostart-hyprland) 2>&1
                  exec ${getExe dex} --autostart --verbose "$@"
                ''
              )}")
            end
          '')
        ];
      }
    ];

    settings.env = [
      {
        _args = [
          "XCURSOR_SIZE"
          "24"
        ];
      }
    ];

    settings.gesture = [
      {
        _args = [
          {
            fingers = 4;
            direction = "horizontal";
            action = "workspace";
          }
        ];
      }
    ];

    settings.bind = [
      {
        _args = [
          "SUPER + mouse:272"
          (generators.mkLuaInline /* Lua */ "hl.dsp.window.drag()")
          { mouse = true; }
        ];
      }
      {
        _args = [
          "SUPER + mouse:273"
          (generators.mkLuaInline /* Lua */ "hl.dsp.window.resize()")
          { mouse = true; }
        ];
      }
    ];

    settings.config.input = {
      follow_mouse = mkDefault 1;
      sensitivity = mkDefault 0;
      touchpad = {
        natural_scroll = mkDefault true;
        clickfinger_behavior = mkDefault false;
        tap_to_click = mkDefault true;
      };
    };
  };
}
