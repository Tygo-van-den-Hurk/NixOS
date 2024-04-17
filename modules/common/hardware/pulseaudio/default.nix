## Defines miscellaneous settings.

{ config, pkgs, lib, machine-settings, ... } : { hardware.pulseaudio = {
        enable = lib.mkDefault false;
    };
}