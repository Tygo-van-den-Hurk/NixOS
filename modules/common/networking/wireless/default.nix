## Defines the networking options.
arguments @ {
  config,
  pkgs,
  lib,
  machine-settings,
  ...
}: {
  networking.wireless = {
    #// enable = (lib.mkDefault true);
  };
}
