## This file contains all the settings that will be used in configuration.nix
#! Changing this will change this setting - unless overwritten - for all machines.
arguments @ { config, pkgs, lib, ... } : {

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SETTINGS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
    
    user = {
        username            = "tygo";       # The username of the main user on the system in lower caps.
        defaultApps = {                     # Sets the default apps to use 
            terminal        = "code";       # The default Termial app to load when opening a terminal.
            editor          = "code";       # The default Editor to load when editing a file.
            browser         = "firefox";    # The default browser open pages with. # TODO : implement this feature
        };  
    };  

    modules = { 
        gui                 = "kde";        # The GUI to use. Go to /modules/gui for an up-to-date list of the options.
        kmonad              = true;         # Wether or not to load the 'kmonad' module.
        nvidia              = false;        # Wether or not to load the 'nvidia' module.
        gaming              = false;        # Wether or not to load the 'gaming' module.
        onedrive            = false;        # wether or not to load the 'onedrive' module.
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

    #! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DANGER ZONE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ !#

    #| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TESTING PROPER FUNCTIONING  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ |#
    # This section is here to test if the settings are working, and are being overwritten properly.

    TESTING_PROPER_FUNCTIONING = {           # This object will contain all the settings to check the output of.
        SYSTEMS_LEVEL = {                    # This object contains all the settings created by the system level.
            SYSTEMS = "WRITTEN BY SYSTEMS";  # Should be "written by systems", and not be overwritten.
            CATEGORY = "WRITTEN BY SYSTEMS"; # Should be "written by category", and be overwritten.
            MACHINE = "WRITTEN BY SYSTEMS";  # Should be "written by machine", and be overwritten.
        };

        # Both Category, and Machine Should add their own sections.
    };
}
