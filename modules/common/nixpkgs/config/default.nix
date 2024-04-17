## Defines Nix packages configuration settings.

{ config, pkgs, lib, machine-settings, ... } : { nixpkgs.config = {
        allowUnfree = lib.mkDefault true;
    };
}