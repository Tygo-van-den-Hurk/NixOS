## Defines display manager / window manager settings.

{ config, pkgs, lib, ... } : { security = {
    };

    imports = [
        ./rtkit
        ./sudo
    ];
}

