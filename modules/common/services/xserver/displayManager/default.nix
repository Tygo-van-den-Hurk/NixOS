## Defines the services that run on the system.

{ config, pkgs, lib, ... } : { services.xserver.displayManager = {
        sddm.enable = true;
        sddm.theme = "breeze";
        # sddm.enableNumlock = true; # does not exist appearantly...?
    };
}
