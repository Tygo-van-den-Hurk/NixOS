## Defines all the settings for the grub boot loader.
#! Cannot be enabled if systemd-boot is enabled.
{ config, pkgs, lib, ... } : { boot.loader.grub = {
        enable = lib.mkDefault true;
        useOSProber = lib.mkDefault  true;
        devices = [ "nodev" ]; 
        #// devices = lib.mkDefault [ "nodev" ]; 
        efiSupport = lib.mkDefault  true;
        #// configurationLimit = 5; 
    };
}