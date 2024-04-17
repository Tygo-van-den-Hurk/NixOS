## This file contains all the settings that will be used in configuration.nix
# use `default-settings // these-settings` to merge these sets.
{
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ USER SETTINGS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
    username            = null; # The username of the main user on the system in lower caps
    hostname            = null; # The hostname of the computer in lower caps
    system              = null; # The architecture the system uses
    remapKeys           = null; # Wether or not to remap the keys to MacOS behavior
    displayManager      = null; # The systems display manager
    desktopManager      = null; # The systems desktop manager
    windowManager       = null; # The systems window manager
    enableGaming        = null; # Wether or not the system should load the gaming module
    nvidia              = null; # Wether or not to load the NVIDIA drivers
    allowUnfreePackages = null; # Wether or not to allow unfree packages
    #! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Danger Zone ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ !#
}