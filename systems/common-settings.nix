## This file contains all the settings that will be used in configuration.nix
#! Changing this will change this setting - unless overwritten - for all machines.
arguments @ { config, pkgs, lib, ... } : {
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SETTINGS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
    user = {
        username            = "tygo";       # The username of the main user on the system in lower caps.
        defaultApps = {                     # Sets the default apps to use 
            terminal        = "code";       # The default Termial app to load when opening a terminal.
            editor          = "code";       # The default Editor to load when editing a file.
            browser         = "";           # The default browser open pages with. # TODO : implement this feature
        };  
    };  

    modules = { 
        kmonad              = true;         # Wether or not to remap the keys to MacOS behavior.
        nvidia              = false;        # Wether or not to load the NVIDIA drivers.
        gaming              = false;        # Wether or not the system should load the gaming module.
        gui                 = "kde";        # The GUI to use. Go to /modules/gui for an up-to-date list of the options.
    };  

    system = {  
        hostname            = null;         # The hostname of the computer in lower caps.
        architecture        = null;         # The architecture the system uses.
        allowUnfreePackages = null;         # Wether or not to allow unfree packages.
        packages = {                        # The packages that should be on the system.
            freeSoftware = with pkgs; [     # The packages that can be installed without `allowUnfreePackages` setting.

            ];
            unFreeSofware = with pkgs; [    #  The packages that can be installed with `allowUnfreePackages` setting.

            ];
        };       
    };


    

    #! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Danger Zone ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ !#
}
