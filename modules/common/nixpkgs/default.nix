## Defines Nix packages configuration settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : { nixpkgs = {
    };

    imports = [
        ( import ./config arguments )
    ];
}