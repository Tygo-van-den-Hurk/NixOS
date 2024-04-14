## Defines all the settings for the boot loader.

{ config, pkgs, lib, ... } : { boot.loader = {
        
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
        
        # #` grub
        # grub = {
        #     enable = true;
        #     useOSProber = true;
        #     devices = [ "/dev/nvme0n1" ]; 
        #     efiSupport = true;
        # };
    };
}