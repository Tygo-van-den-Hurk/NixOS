## Defines all the settings for the grub boot loader.
#! Cannot be enabled if systemd-boot is enabled.
arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    yes = builtins.trace ("Loading: /modules/common/boot/loader/grub...") (true); 

in { boot.loader.grub = {
        enable      = lib.mkDefault yes;
        useOSProber = lib.mkDefault yes;
        efiSupport  = lib.mkDefault yes;
        #// configurationLimit = 5; 
        devices     = [ "nodev" ]; 
    };
}