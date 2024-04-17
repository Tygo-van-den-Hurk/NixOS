## This file contains all the settings that will be used in configuration.nix
#! Changing this will change this setting - unless overwritten - for all machines.
{
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SETTINGS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
    user = {
        username            = null; # The username of the main user on the system in lower caps
    };

    modules = {
        kmonad              = false; # Wether or not to remap the keys to MacOS behavior
        nvidia              = false; # Wether or not to load the NVIDIA drivers
        gaming              = false; # Wether or not the system should load the gaming module
    };

    system = {
        hostname            = null; # The hostname of the computer in lower caps
        architecture        = null; # The architecture the system uses
        allowUnfreePackages = null; # Wether or not to allow unfree packages
    };

    gui = {
        displayManager      = null; # The systems display manager
        desktopManager      = null; # The systems desktop manager
        windowManager       = null; # The systems window manager
    };

    #! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Danger Zone ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ !#
}