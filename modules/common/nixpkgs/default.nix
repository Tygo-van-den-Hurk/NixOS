## Defines Nix packages configuration settings.

{ config, pkgs, lib, ... } : { nixpkgs = {
    };

    imports = [
        ./config
    ];
}