## Defines all the settings for the boot loader.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 
    
    boot.loader.efi = {
        canTouchEfiVariables = (lib.mkDefault true);
        #// efiSysMountPoint = (lib.mkDefault "/boot/efi");
    };
})
