## Defines the pipewire service.
{
  lib,
  ...
}:
{
  services.pipewire = {
    enable = lib.mkDefault true;
    alsa.enable = lib.mkDefault true;
    alsa.support32Bit = lib.mkDefault true;
    pulse.enable = true; # lib.mkDefault true;
  };
}
