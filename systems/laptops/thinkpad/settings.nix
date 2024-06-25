## This is the specific Setting file for this machine
#! Any setting you write here will overwrite whatever anyone has tried to set before.
{ # add updates below:

    users = let username = "tygo"; in {
        "${username}".init.modules.nfs = {
            enable = true;
            servers."tygos-nasserver" = {
                enable = true;
                shares."school" = {
                    enable = true;
                    mount-location = "/home/${username}/school/";
                };
            };
        };
    };

    system = {
        hostname = "tygos-thinkpad-nixos";
        architecture = "86x_64-linux";
        packages.allowUnfree = true;
        modules = {
            local-ai = {
                enable       = true;
                acceleration = "cuda";
                backend      = "docker";
                devices = {
                    cuda     = "0";
                    hip      = "";
                };
            };
            nvidia = {  
                hardwarePackage   = "stable";
                prime = {  
                    offload       = true;
                    nvidia        = "PCI:1:0:0";
                    intel         = "PCI:0:2:0";
                };
            };
        };
    };

    modules.gui = "i3wm";
}
