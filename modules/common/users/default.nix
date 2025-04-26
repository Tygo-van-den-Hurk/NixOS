## Defines the user options.
arguments @ {
  config,
  pkgs,
  lib,
  machine-settings,
  ...
}: {
  imports = [
    ./extraUsers
  ];
}
