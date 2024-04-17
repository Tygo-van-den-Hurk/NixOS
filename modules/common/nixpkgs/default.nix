## Defines Nix packages configuration settings.

{ config, pkgs, lib, machine-settings, ... } : { nixpkgs = {
    };

    imports = [
        ./config
    ];
}