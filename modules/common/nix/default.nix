## Defines nix settings.

{ config, pkgs, lib, ... } : { nix = {
    };

    imports = [
        ./settings
        ./gc
    ];
}
