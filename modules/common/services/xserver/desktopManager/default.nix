## Defines the services that run on the system.

{ config, pkgs, lib, ... } : { services.xserver.desktopManager = {
        plasma5.enable = true;
    };
}
