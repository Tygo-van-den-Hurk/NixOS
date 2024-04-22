## Defines i3wm settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    yes = builtins.trace ("Loading: /modules/gui/i3wm...") (true); 

in {
    
    programs.dconf.enable = true;

    services.xserver.enable                         = yes;
    services.xserver.desktopManager.xterm.enable    = yes;
    
    services.xserver.displayManager.defaultSession  = "none+i3";

    services.xserver.windowManager.i3.enable        = yes;
    services.xserver.windowManager.i3.extraPackages = with pkgs; [
        dmenu       #application launcher most people use
        i3status    # gives you the default i3 status bar
        i3lock      #default i3 screen locker
        i3blocks    #if you are planning on using i3blocks over i3status
        nitrogen    # wallpaper engine
    ];

    # Depricated: services.xserver.libinput.naturalScrolling = yes;
    services.xserver.libinput.touchpad.naturalScrolling = yes;
    
    environment.pathsToLink = [ "/libexec" ];
}