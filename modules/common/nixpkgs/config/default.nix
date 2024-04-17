## Defines Nix packages configuration settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : { nixpkgs.config = {
        allowUnfree = lib.mkDefault true;
    };
}