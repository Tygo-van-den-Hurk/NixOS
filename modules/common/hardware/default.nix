## Defines miscellaneous settings.

{ config, pkgs, lib, ... } : { hardware = {
    };

    imports = [
        ./pulseaudio
    ];
}