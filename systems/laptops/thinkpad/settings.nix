## This is the specific Setting file for this machine
#! Any setting you write here will overwrite whatever anyone has tried to set before.
{ # add updates below:

    users = let username = "tygo"; in {
        "${username}".init.modules = { 
            docker.enable = true;
            virtualbox.enable = false;
        };
    };

    system = {
        hostname = "tygos-thinkpad-nixos";
        architecture = "86x_64-linux";
        packages.allowUnfree = true;
        modules = {

            gaming.enable = true;
            
            gpg.enable = true;

            local-ai = {
                enable       = false;
                acceleration = "cuda";
                backend      = "docker";
                devices = {
                    cuda     = "0";
                    hip      = "";
                };
            };

            nvidia = {  
                enable = true;
                hardwarePackage   = "stable";
                prime = {  
                    offload       = true;
                    nvidia        = "PCI:1:0:0";
                    intel         = "PCI:0:2:0";
                };
            };
        };
    };
}
