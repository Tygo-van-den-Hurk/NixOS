## Defines nix settings.

{ config, pkgs, lib, ... } : { nix.settings = {
    };

    imports = [
        ./experimental-features
    ];
}
