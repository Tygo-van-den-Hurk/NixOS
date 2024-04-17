## Defines nix settings.

{ config, pkgs, lib, machine-settings, ... } : { nix.settings = {
    };

    imports = [
        ./experimental-features
    ];
}
