## This file contains all the settings that will be used in configuration.nix
#! Changing this will change this setting - unless overwritten - for all machines.
arguments @ { config, pkgs, lib, ... } : {

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SETTINGS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
    
    user = {
        username            = "tygo";       # The username of the main user on the system in lower caps.
        defaultApps = {                     # Sets the default apps to use 
            terminal        = "alacritty";  # The default Termial app to load when opening a terminal.
            editor          = "code";       # The default Editor to load when editing a file.
            browser         = "firefox";    # The default browser open pages with. # TODO : implement this feature
        };  
    };  

    modules = { 
        gui                 = "kde";        # The GUI to use. Go to /modules/gui for an up-to-date list of the options.
        nvidia              = false;        # Wether or not to load the 'nvidia' module.
        gaming              = false;        # Wether or not to load the 'gaming' module.
        onedrive            = false;        # wether or not to load the 'onedrive' module.
        virtualbox          = false;        # wether or not to load the 'virtualbox' module.
        openssh             = false;        # wether or not to load the 'openssh' module.
        key-remapper        = "xremap";     # wether or not to load the 'xremap' module.
        java                = false;        # wether or not to load the 'java' module.
        docker              = false;        # wether or not to load the 'docker' module.
    };  

    system = {  
        type                = null;         # The type of the system, example is "laptop".
        hostname            = null;         # The hostname of the computer in lower caps.
        architecture        = null;         # The architecture the system uses.
        packages = {     
            allowUnfree     = null;         # Wether or not to allow unfree packages.
            # TODO : Make the packages definable in the settings. Currently that causes infinite recursion.
            # freeSoftware    = [  # The packages that can be installed without `allowUnfreePackages` setting.
            #     firefox
            # ];
            # unFreeSoftware  = with pkgs; [  #  The packages that can be installed with `allowUnfreePackages` setting.
            # 
            # ];
        };       
    };

    #! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DANGER ZONE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ !#

    #| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TESTING PROPER FUNCTIONING  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ |#
    # This section is here to test if the settings are working, and are being overwritten properly.

    TESTING_PROPER_FUNCTIONING = {           # This object will contain all the settings to check the output of.
        SYSTEMS_LEVEL = {                    # This object contains all the settings created by the system level.
            SYSTEMS  = "written by systems, and not supposed to be overriden";  
            CATEGORY = "written by systems, and supposed to be overriden by category";
            MACHINE  = "written by systems, and supposed to be overriden by category, and then by machine"; 
        };

        # Both Category, and Machine Should add their own sections.
    };
}
