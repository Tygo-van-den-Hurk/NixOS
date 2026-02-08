## Defines Nix packages configuration settings.
{
  config,
  lib,
  machine-settings,
  ...
}:
{
  nixpkgs.config = {
    allowUnfree = lib.mkDefault machine-settings.system.packages.allowUnfree;
  };
}
