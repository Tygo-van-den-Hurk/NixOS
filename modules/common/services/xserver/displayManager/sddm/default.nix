## Defines the services that run on the system.

{ config, pkgs, lib, machine-settings, ... } : { services.xserver.displayManager.sddm = {
        enable = true;
        theme = "breeze";
        # enableNumlock = true; #? does not exist appearantly...?
    };
}
