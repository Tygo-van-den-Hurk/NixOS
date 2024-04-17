## Defines nix settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : { nix.settings = {
    };

    imports = [
        ( import ./experimental-features arguments )
    ];
}
