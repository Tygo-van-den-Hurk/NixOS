## Defines display manager / window manager settings.
arguments @ {
  config,
  pkgs,
  lib,
  machine-settings,
  ...
}: {
  imports = [
    ./rtkit
    ./sudo
  ];
}
