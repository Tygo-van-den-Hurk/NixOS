## Defines the services that run on the system.

{ config, pkgs, lib, machine-settings, ... } : { services.xserver.displayManager = {
        # defaultSession = "none+i3";
    };

    imports = [
        ./sddm
    ];
}
