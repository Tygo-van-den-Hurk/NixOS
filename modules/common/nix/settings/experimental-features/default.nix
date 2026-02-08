## Defines nix settings.
{
  lib,
  ...
}:
{
  nix.settings.experimental-features = lib.mkForce [
    "nix-command" # Used to enable the use of the `nix` program.
    "flakes" # Used to add flake support.
  ];
}
