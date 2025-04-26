## Defines the services that run on the system.
arguments @ {
  config,
  pkgs,
  lib,
  machine-settings,
  ...
}: {
  imports = [
    ./espanso
    ./libinput
    ./logind
    ./pipewire
    ./printing
    ./tailscale
  ];
}
