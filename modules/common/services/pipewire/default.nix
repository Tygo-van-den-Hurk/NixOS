## Defines the pipewire service.
arguments @ {
  config,
  pkgs,
  lib,
  machine-settings,
  ...
}: {
  services.pipewire = {
    enable = lib.mkDefault true;
    alsa.enable = lib.mkDefault true;
    alsa.support32Bit = lib.mkDefault true;
    pulse.enable = lib.mkDefault true;
  };
}
