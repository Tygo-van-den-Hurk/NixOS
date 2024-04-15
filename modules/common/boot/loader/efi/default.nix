## Defines all the settings for the boot loader.

{ config, pkgs, lib, ... } : { boot.loader.efi = {
        canTouchEfiVariables = lib.mkDefault true;
        #// efiSysMountPoint = "/boot/efi";
    };
}