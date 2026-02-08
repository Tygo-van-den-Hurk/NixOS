## Enabled podman as a service.
{
  pkgs,
  lib,
  machine-settings,
  ...
}:
let
  module-settings = machine-settings.system.modules.podman;
in
if module-settings.enable then
  builtins.trace "(System) Loading: ${toString ./.}..." {
    virtualisation = {
      containers.enable = true;
      podman = {
        enable = lib.mkDefault true;
        dockerCompat = lib.mkDefault module-settings.dockerCompat;
        defaultNetwork.settings.dns_enabled = lib.mkDefault true;
      };
    };

    environment.systemPackages = with pkgs; [
      dive
      podman-tui
      podman-compose
    ];
  }
else
  { }
