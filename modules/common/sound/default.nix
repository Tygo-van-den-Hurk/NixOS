## Defines miscellaneous settings.

{ config, pkgs, lib, machine-settings, ... } : { sound = {
        enable = lib.mkDefault true;
    };
}