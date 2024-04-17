## Defines the services that run on the system.

{ config, pkgs, lib, machine-settings, ... } : { services.xserver.desktopManager.xterm = {
        enable = lib.mkDefault false;
    };
}
