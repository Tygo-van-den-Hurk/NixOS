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
      action.hyprland = "exec, hyprctl reload";
      action.i3 = "reload";
    };

    "restart session" = {
      super = true;
      shift = true;
      key = "r";
      action.hyprland = "exec, hyprctl reload";
      action.i3 = "restart";
    };

    "locking your screen" = {
      super = true;
      control = true;
      key = "q";
      action.hyprland = "exec, ${getExe hyprlock}";
      action.i3 = "exec ${getExe i3lock}";
    };

    "logging you out" = {
      super = true;
      shift = true;
      key = "q";
      action.hyprland = "exit"; # TODO: add confirmation box
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
