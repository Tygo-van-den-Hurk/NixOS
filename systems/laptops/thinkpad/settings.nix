## This is the specific Setting file for this machine
#! Any setting you write here will overwrite whatever anyone has tried to set before.
arguments @ { config, pkgs, lib, ... } : { # add updates below:

    system.hostname = "tygos-thinkpad";
    system.architecture = "86x_64-linux";


    #| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TESTING PROPER FUNCTIONING  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ |#
    # This section is here to test if the settings are working, and are being overwritten properly.

    TESTING_PROPER_FUNCTIONING = { # This object will contain all the settings to check the output of.
        SYSTEMS_LEVEL.MACHINE  = "written by machine, and overridden twice"; # Should be "written by machine".
        CATEGORY_LEVEL.MACHINE = "written by machine, and overridden once"; # Should be "written by machine".
        MACHINE_LEVEL.MACHINE  = "written by machine"; # Should be "written by machine".
    };
}