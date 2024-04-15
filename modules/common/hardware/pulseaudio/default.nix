## Defines miscellaneous settings.

{ config, pkgs, lib, ... } : { hardware.pulseaudio = {
        enable = lib.mkDefault false;
    };
}