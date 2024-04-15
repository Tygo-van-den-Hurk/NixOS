## Defines all the settings for the boot loader.

{ config, pkgs, lib, ... } : { boot.loader = {
        timeout = 5;    
    };

    imports = [
        ./efi
        ./grub
        ./systemd-boot
    ];
}