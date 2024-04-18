## Defines Gnome settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    yes = builtins.trace ("Loading: /modules/gui/hyperland...") (true); 

in { 
    
    #| required settings
    services.xserver.enable                       = lib.mkDefault yes;
    services.xserver.displayManager.gdm.enable    = lib.mkDefault yes;
    services.xserver.desktopManager.gnome.enable  = lib.mkDefault yes;

    #| Patches
    hardware.pulseaudio.enable = lib.mkDefault yes;
    services.pipewire.enable   = lib.mkDefault yes;
}