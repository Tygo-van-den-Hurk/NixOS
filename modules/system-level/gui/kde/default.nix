## Defines KDE settings.
{
  machine-settings,
  ...
}:
let
  this-module-is-enabled = machine-settings.system.modules.gui.kde.enable;
in
if this-module-is-enabled then
  (builtins.trace "(System) Loading: ${toString ./.}..." {
    services.xserver.enable = true;
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;
  })
else
  { }
