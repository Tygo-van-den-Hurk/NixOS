## Defines the services that run on the system.
arguments @ {
  config,
  pkgs,
  lib,
  machine-settings,
  ...
}: {
  services.libinput = {
    touchpad.naturalScrolling = true;
  };
}
