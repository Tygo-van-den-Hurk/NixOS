## Defines the networking options.
{
  lib,
  machine-settings,
  ...
}:
{
  imports = [
    ./firewall
    ./networkmanager
    ./proxy
    ./wireless
  ];

  networking = {
    hostName = lib.mkDefault machine-settings.system.hostname;
  };
}
