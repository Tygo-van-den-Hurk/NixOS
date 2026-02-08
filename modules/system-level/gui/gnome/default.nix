## Defines Gnome settings.
{
  lib,
  machine-settings,
  ...
}:
let
  this-module-is-enabled = machine-settings.system.modules.gui.gnome.enable;
in
if this-module-is-enabled then
  (builtins.trace "(System) Loading: ${toString ./.}..." {
    #| required settings
    services.xserver.enable = lib.mkDefault true;
    services.xserver.displayManager.gdm.enable = lib.mkDefault true;
    services.xserver.desktopManager.gnome.enable = lib.mkDefault true;

    #| Patches
    hardware.pulseaudio.enable = true; # lib.mkDefault true;
    services.pipewire.enable = lib.mkDefault true;
  })
else
  { }
