_:

{
  cli.enable = true;
  gui.enable = true;
  styling.enable = true;
  wm.enable = true;

  home.username = "tygo";
  home.homeDirectory = "/home/tygo";
  home.stateVersion = "25.05";

  wm.monitors."builtin display" = {
    primary = true;
    adapter = "eDP-1";
    refresh-rate = 60;
    resolution.vertical = 1080;
    resolution.horizontal = 1920;
    position.vertical = 0;
    position.horizontal = 0;
  };

  wm.monitors."HDMI port" = {
    primary = true;
    adapter = "HDMI-1";
    refresh-rate = 60;
    resolution.vertical = 1080 * 2;
    resolution.horizontal = 1920 * 2;
    position.vertical = 1080;
    position.horizontal = 0;
  };

  wm.monitors."USB-C" = {
    primary = true;
    adapter = "DP-1";
    refresh-rate = 60;
    resolution.vertical = 1080 * 2;
    resolution.horizontal = 1920 * 2;
  };
}
