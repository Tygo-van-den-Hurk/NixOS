## Defines Hyperland settings.
#! This is just for non-NVIDIA users. If you have an NVIDIA GPU, you must add some patches. 
arguments @ { config, pkgs, lib, machine-settings, programs, ... } : let 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    yes = builtins.trace ("Loading: /modules/gui/hyperland...") (true); 

    wallpaperApp = "swww"; # used to select which wallpaper app to use.

in { # See https://www.youtube.com/watch?v=61wGzIv12Ds

    programs.hyperland.enable  = yes; # check '!' comment

    environment.systemPackages = with pkgs; [ 
        ( waybar.overrideAttrs (
            #! if waybar is not installed add a seprate 'waybar' in this list.
            # this is because I don't know if this override also adds the package.
            oldAttrs : { 
                mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; 
            })
        )
        eww             # 
        dunst           # Notifications 
        libnotify       # Dependancy from 'dunst'.
        rofi-wayland    # Application launcher know as 'rofi', this is the wayland version.
        kitty           # The terminal Hyperland assumes you use.
        #| Programs for wallpapers
        ( 
            if ( wallpaperApp == "hyperpaper" ) then ( hyperpaper ) else 
            if ( wallpaperApp == "swaybg"     ) then ( swaybg ) else 
            if ( wallpaperApp == "wpaperd"    ) then ( wpaperd ) else 
            if ( wallpaperApp == "mpvpaper"   ) then ( mpvpaper ) else 
            if ( wallpaperApp == "swww"       ) then ( swww ) else 
            abort (
                "Error: \"${wallpaperApp}\" is not one of the avaible choices for a wallpaper service. " +
                "Please go to '/modules/gui/hyperland/default.nix', and make an adjustment in the 'let in' binding. "
            )
        )  
    ];

    xdg.portal = {
        enable = yes;   # enables portals
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };

    sound.enable = yes;
    security.rtkit.enable = yes;
    services.pipewire = {
        enable            = yes;
        alsa.enable       = yes;
        alsa.support32Bit = yes;
        pulse.enable      = yes;
    };
}
