## Defines the tailscale service.
{
  pkgs,
  lib,
  ...
}:
{
  services.tailscale.enable = lib.mkDefault true;

  environment.systemPackages = [ pkgs.tailscale ];

  networking.firewall.checkReversePath = lib.mkDefault "loose"; # Fix for TailScale
}
