## Defines all the settings for the boot loader.
{
  lib,
  ...
}:
{
  boot.loader.efi = {
    canTouchEfiVariables = lib.mkDefault true;
  };
}
