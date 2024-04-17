## Defines all the settings for the boot loader.
#! Cannot be enabled if grub is enabled.
arguments @ { config, pkgs, lib, machine-settings, ... } : { boot.loader.systemd-boot = {
        enable = lib.mkDefault false;
    };
}