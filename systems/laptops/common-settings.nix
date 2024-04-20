## This file contains the common settings for this category.
#! This file will overwrite the global settings!
arguments @ { config, pkgs, lib, ... } : let

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    common-settings = builtins.trace "machine-settings at /system:\n\t${builtins.toJSON cs_}" (cs_);
    cs_ = ( import ../common-settings.nix arguments );

in ( common-settings // { # add updates below:


    #| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TESTING PROPER FUNCTIONING  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ |#
    # This section is here to test if the settings are working, and are being overwritten properly.

    TESTING_PROPER_FUNCTIONING = { # This object will contain all the settings to check the output of.
        SYSTEMS_LEVEL.CATEGORY = "WRITTEN BY CATEGORY"; # Should be "written by category", and should be overwritten.
        CATEGORY_LEVEL = {                     # Contains all the settings added by category.
            CATEGORY = "WRITTEN BY CATEGORY";  # Should be "written by category", and should not be overwritten.
            MACHINE  = "WRITTEN BY CATEGORY";  # Should be "written by machine", and should be overwritten by machine.
        };

        # Machine Should add their own section.
    };
})
