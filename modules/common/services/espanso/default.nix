## Defines the services that run on the system.
{
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [ espanso ];

  services.espanso = {
    enable = lib.mkDefault true;
  };
}
