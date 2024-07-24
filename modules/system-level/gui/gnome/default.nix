## Defines Gnome settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    
    this-module-is-enabled = machine-settings.system.modules.gui.gnome.enable;

in ( if ( this-module-is-enabled == true ) then (builtins.trace "Loading: ${toString ./.}..." {
      
    #| required settings
    services.xserver.enable                      = lib.mkDefault true;
    services.xserver.displayManager.gdm.enable   = lib.mkDefault true;
    services.xserver.desktopManager.gnome.enable = lib.mkDefault true;

    #| Patches
    hardware.pulseaudio.enable = lib.mkDefault true;
    services.pipewire.enable   = lib.mkDefault true;

}) else {})
