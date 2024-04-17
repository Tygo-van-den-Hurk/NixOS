## Defines all the settings for the boot loader.

arguments @ { config, pkgs, lib, machine-settings, ... } : { boot.loader = {
        timeout = 5;    
    };

    imports = [
        ( import  ./efi           arguments )
        ( import  ./grub          arguments )
        ( import  ./systemd-boot  arguments )
    ];
}