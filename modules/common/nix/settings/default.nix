## Defines nix settings.
arguments @ {
  config,
  pkgs,
  lib,
  machine-settings,
  ...
}: {
  imports = [./experimental-features];
}
