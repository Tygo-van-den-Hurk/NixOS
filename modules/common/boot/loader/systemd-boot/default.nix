## Defines all the settings for the boot loader.
#! Cannot be enabled if grub is enabled.
{ config, pkgs, lib, ... } : { boot.loader.systemd-boot = {
        enable = lib.mkDefault false;
    };
}