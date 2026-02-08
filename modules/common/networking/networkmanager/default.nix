## Defines the network manager options.
{
  lib,
  ...
}:
{
  networking.networkmanager = {
    enable = lib.mkDefault true;
  };
}
