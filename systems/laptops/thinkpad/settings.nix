## This is the specific Setting file for this machine
#! Any setting you write here will overwrite whatever anyone has tried to set before.
{ # add updates below:

    system = {
        hostname = "tygos-thinkpad-nixos";
        architecture = "86x_64-linux";
        packages.allowUnfree = true;
        modules = {
            local-ai = {
                enable = true;
                acceleration = "cuda";
            };
        };
    };

    modules = {
        gui                   = "i3wm";
        java                  = "jdk21";
        gaming                = true;
        docker                = true;
        nvidia = {  
            hardwarePackage   = "stable";
            prime = {  
                offload       = true;
                nvidia        = "PCI:1:0:0";
                intel         = "PCI:0:2:0";
            };
        };

        # under development
        # nfs.tygos-nasserver = {
        #     location = "100.x.x.x";
        #     authentication = {
        #         username = "";
        #         password = "";
        #     }; 
        #     shares = {
        #         "documents".enabled = false;
        #         "school".enabled = false;
        #         "work".enabled = false;
        #     };
        # };

        # currently to unstable 
        #// gui               = "hyprland";
        
        # This module can dramatically increate switch time when it gets an update as it compiles from source
        #// virtualbox        = true;
    };

    # #| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TESTING PROPER FUNCTIONING  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ |#
    # # This section is here to test if the settings are working, and are being overwritten properly.

    # TESTING_PROPER_FUNCTIONING = { # This object will contain all the settings to check the output of.
    #     SYSTEMS_LEVEL.MACHINE  = "written by machine, and overridden twice"; # Should be "written by machine".
    #     CATEGORY_LEVEL.MACHINE = "written by machine, and overridden once"; # Should be "written by machine".
    #     MACHINE_LEVEL.MACHINE  = "written by machine"; # Should be "written by machine".
    # };
}
