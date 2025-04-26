## Defines miscellaneous settings.
arguments @ {
  config,
  pkgs,
  lib,
  machine-settings,
  ...
}: {
  imports = [
    ./pulseaudio
  ];
}
