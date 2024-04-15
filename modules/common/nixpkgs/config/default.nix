## Defines Nix packages configuration settings.

{ config, pkgs, lib, ... } : { nixpkgs.config = {
        allowUnfree = lib.mkDefault true;
    };
}