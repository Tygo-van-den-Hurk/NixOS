## Defines miscellaneous settings.
{
  lib,
  ...
}:
{
  hardware.pulseaudio = {
    enable = lib.mkDefault false;
  };
}
