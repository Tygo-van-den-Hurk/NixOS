## Defines miscellaneous settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : { hardware = {
    };

    imports = [
        ( import ./pulseaudio arguments )
    ];
}