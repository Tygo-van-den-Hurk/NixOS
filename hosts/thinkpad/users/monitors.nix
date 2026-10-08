{
  self.wm.monitors."builtin" = {
    primary = true;
    adapter = "eDP-1";
    refresh-rate = 60;
    resolution.vertical = 1080;
    resolution.horizontal = 1920;
    position.vertical = 0;
    position.horizontal = 0;
  };

  self.wm.monitors."HDMI" = {
    primary = true;
    adapter = "HDMI-1";
    refresh-rate = 60;
    resolution.vertical = 1080 * 2;
    resolution.horizontal = 1920 * 2;
    position.vertical = 1080;
    position.horizontal = 0;
  };

  self.wm.monitors."USB-C" = {
    primary = true;
    adapter = "DP-1";
    refresh-rate = 60;
    resolution.vertical = 1080 * 2;
    resolution.horizontal = 1920 * 2;
  };
}
