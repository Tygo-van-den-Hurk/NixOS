{
  pkgs,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  type = "wm";
  category = "shortcuts";
in
{
  config.${namespace}.${type}.${category} = with pkgs; {
    #
    #  This is for key bindings that do session management. Things such as:
    #
    #  - Reloading your configuration off disk
    #  - Restarting your session
    #  - Logging you out, or locking your screen
    #

    "reload configuration" = {
      super = true;
      shift = true;
      key = "c";
      action.i3 = "reload";
      action.hyprland = generators.mkLuaInline /* Lua */ ''
        hl.dsp.exec_cmd("hyprctl reload")
      '';
    };

    "restart session" = {
      super = true;
      shift = true;
      key = "r";
      action.i3 = "restart";
      action.hyprland = generators.mkLuaInline /* Lua */ ''
        hl.dsp.exec_cmd("hyprctl reload")
      '';
    };

    "locking your screen" = {
      super = true;
      control = true;
      key = "q";
      action.i3 = "exec ${getExe i3lock}";
      action.hyprland = generators.mkLuaInline /* Lua */ ''
        hl.dsp.exec_cmd("${getExe hyprlock}")
      '';
    };

    "logging you out" = {
      super = true;
      shift = true;
      key = "q";
      # TODO: add confirmation box
      action.hyprland = generators.mkLuaInline /* Lua */ ''
        hl.dsp.exit()
      '';

      action.i3 = "exec ${getExe (
        writeShellScriptBin "log-out-confirm-i3" ''
            exec > >(systemd-cat -t log-out-confirm-i3) 2>&1
          ${i3}/bin/i3-nagbar -t warning \
            -m 'Are you sure you want to log out?' \
            -B 'confirm' '${i3}/bin/i3-msg exit'
        ''
      )}";
    };
  };
}
