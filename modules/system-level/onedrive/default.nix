## This module enables onedrive on the system https://nixos.wiki/wiki/OneDrive
{
  machine-settings,
  ...
}:
let
  module-settings = machine-settings.system.modules.onedrive;
in
if module-settings.enable then
  builtins.trace "(System) Loading: ${toString ./.}... " {
    services.onedrive.enable = true;
  }
else
  { }
