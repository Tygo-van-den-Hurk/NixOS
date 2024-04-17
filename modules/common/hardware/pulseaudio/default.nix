## Defines miscellaneous settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : { hardware.pulseaudio = {
        enable = lib.mkDefault false;
    };
}