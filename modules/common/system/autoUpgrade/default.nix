## Defines the systems auto upgrade settings.
{
  lib,
  ...
}:
{
  system.autoUpgrade = {
    enable = lib.mkDefault true;
    flake = lib.mkDefault "github:Tygo-van-den-Hurk/NixOS";
    allowReboot = lib.mkDefault false;
  };
}
