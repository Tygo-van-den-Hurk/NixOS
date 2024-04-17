## Defines the systems auto upgrade settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : { system.autoUpgrade = { 
        enable = lib.mkDefault true;
    };
}