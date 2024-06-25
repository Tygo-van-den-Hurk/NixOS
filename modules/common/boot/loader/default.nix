## Defines all the settings for the boot loader.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 

    imports = [ ./efi ./grub ./systemd-boot ];

    boot.loader = {
        timeout = (lib.mkDefault 5);    
    };
})
