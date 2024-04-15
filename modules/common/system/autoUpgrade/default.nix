## Defines the systems auto upgrade settings.

{ config, pkgs, lib, ... } : { system.autoUpgrade = { 
        enable = lib.mkDefault true;
    };
}