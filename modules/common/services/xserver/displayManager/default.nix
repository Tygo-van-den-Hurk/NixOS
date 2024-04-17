## Defines the services that run on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : { services.xserver.displayManager = {
        # defaultSession = "none+i3";
    };

    imports = [
        ( import ./sddm arguments )
    ];
}
