## Defines environment settings.
arguments @ {
  config,
  pkgs,
  lib,
  machine-settings,
  ...
}: {
  imports = [
    ./systemPackages
  ];
}
