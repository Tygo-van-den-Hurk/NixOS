## Defines the services that run on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : { services.xserver.displayManager.sddm = {
        enable = lib.mkDefault true;
        theme = lib.mkDefault "breeze";
        # enableNumlock = true; #? does not exist appearantly...?
    };
}
