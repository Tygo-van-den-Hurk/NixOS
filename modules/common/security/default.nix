## Defines display manager / window manager settings.

{ config, pkgs, lib, machine-settings, ... } : { security = {
    };

    imports = [
        ./rtkit
        ./sudo
    ];
}

