## Defines Gnome settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : { 
    
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    
}