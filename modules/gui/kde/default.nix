## Defines KDE settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : { 
    
    services.xserver.enable = true;
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;

}