## Defines miscellaneous settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : { sound = {
        enable = lib.mkDefault true;
    };
}