## Defines all the settings for the boot loader.

arguments @ { config, pkgs, lib, machine-settings, ... } : { boot.loader.efi = {
        canTouchEfiVariables = lib.mkDefault true;
        #// efiSysMountPoint = "/boot/efi";
    };
}