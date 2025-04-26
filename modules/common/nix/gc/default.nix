## Defines nix garbage collection settings.
arguments @ {
  config,
  pkgs,
  lib,
  machine-settings,
  ...
}: {
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 30d";
  };
}
