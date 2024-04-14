## Defines all the settings for the boot loader.

{ config, pkgs, lib, ... } : { boot.loader = {

        timeout = 5;    

        #` efi
        efi = {
            canTouchEfiVariables = true;
            # efiSysMountPoint = "/boot/efi";
        };
        
        #` grub
        grub = {
            enable = true;
            useOSProber = true;
            devices = [ "nodev" ]; 
            efiSupport = true;
            # I removed configurationLimit to display them all.
            #// configurationLimit = 5; 
        };

        #` systemd-boot
        # systemd-boot = { 
        #     #! Cannot be enabled if grub is enabled.
        #     enable = true;
        # };
    };
}