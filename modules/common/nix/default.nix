## Defines nix settings.

{ config, pkgs, lib, machine-settings, ... } : { nix = {
    };

    imports = [
        ./settings
        ./gc
    ];
}
