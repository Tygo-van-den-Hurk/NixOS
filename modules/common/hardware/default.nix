## Defines miscellaneous settings.

{ config, pkgs, lib, machine-settings, ... } : { hardware = {
    };

    imports = [
        ./pulseaudio
    ];
}