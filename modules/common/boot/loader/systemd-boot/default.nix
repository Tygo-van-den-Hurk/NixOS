## Defines all the settings for the boot loader.
#! Cannot be enabled if grub is enabled.
arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    no = builtins.trace ("Loading: /modules/common/boot/loader/systemd-boot...") (false);

in { boot.loader.systemd-boot = {
        enable = lib.mkDefault no;
    };
}