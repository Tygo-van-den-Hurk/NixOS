## enables via on the system for qmk
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
{
  pkgs,
  machine-settings,
  ...
}:
let
  module-settings = machine-settings.system.modules.via;
in
if module-settings.enable then
  builtins.trace "(System) Loading: ${toString ./.}..." {
    hardware.keyboard.qmk.enable = true;
    services.udev.packages = [ pkgs.via ];
    environment.systemPackages = [ pkgs.via ];
  }
else
  { }
