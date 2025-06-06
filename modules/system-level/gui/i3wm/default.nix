## Defines i3wm settings.
arguments @ {
  config,
  pkgs,
  lib,
  machine-settings,
  ...
}: let
  this-module-is-enabled = machine-settings.system.modules.gui.i3wm.enable;
in (
  if (this-module-is-enabled == true)
  then
    (builtins.trace "(System) Loading: ${toString ./.}..." {
      programs.dconf.enable = lib.mkDefault true;
      services.displayManager.sddm = {
        enable = true;
        autoLogin.relogin = true;
        autoNumlock = true;
        theme = "chili";
        settings.Autologin = {
          Session = "i3";
          User = "tygo";
        };
      };

      services.xserver = {
        enable = lib.mkDefault true;

        desktopManager.xterm.enable = lib.mkDefault true;

        windowManager.i3 = {
          enable = lib.mkDefault true;
          extraPackages = with pkgs; [
            sddm-chili-theme # Theme for SDDM
            dmenu # application launcher most people use
            i3status # gives you the default i3 status bar
            i3lock # default i3 screen locker
            i3blocks # if you are planning on using i3blocks over i3status
            nitrogen # wallpaper engine
            brightnessctl # allows for adjusting the screen brightness.
            pulseaudio # allows for adjusting the volume.
            wmctrl # to interact with windows for window managers.
            maim # for taking screenshots
            xclip # for pushing things to the clibboard
            xdotool # For getting the active window
            mpg123 # for playing sounds (first used for taking screen shot sounds)
          ];
        };
      };

      environment.pathsToLink = ["/libexec"];
    })
  else {}
)
