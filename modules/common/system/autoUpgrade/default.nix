## Defines the systems auto upgrade settings.

{ config, pkgs, lib, machine-settings, ... } : { system.autoUpgrade = { 
        enable = lib.mkDefault true;
    };
}