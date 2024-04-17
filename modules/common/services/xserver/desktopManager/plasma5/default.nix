## Defines the services that run on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : { services.xserver.desktopManager.plasma5 = {
        enable = lib.mkDefault true;
    };
}
