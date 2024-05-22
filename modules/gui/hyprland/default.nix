## Defines Hyperland settings.
#! This is just for non-NVIDIA users. If you have an NVIDIA GPU, you must add some patches. 
arguments @ { config, pkgs, lib, machine-settings, programs, ... } : let 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    yes = builtins.trace ("Loading: /modules/gui/hyperland...") (true); 

    wallpaperApp = "swww"; # used to select which wallpaper app to use.

    #| Suggestion ID --> link to the suggestion
    #? id=FRDyE5PUJj --> https://www.reddit.com/r/hyprland/s/FRDyE5PUJj
    #? id=fM7Zqy5uak --> https://discourse.nixos.org/t/how-to-enable-login-screen-and-start-hyperland-after-login/37775

in ({ # See https://www.youtube.com/watch?v=61wGzIv12Ds

    services.xserver.enable = yes; 
    services.xserver.libinput.touchpad.naturalScrolling = yes;

    #|\/ \/ \/ BEGIN PATCHES FROM REDDIT \/ \/ \/ 
    #` below patches from: id=FRDyE5PUJj
    services.xserver.displayManager.sddm.enable = yes;
    #` below patches from: id=fM7Zqy5uak 
    services.xserver.displayManager.sddm.wayland.enable = true;
    services.xserver.displayManager.sddm.theme = "where_is_my_sddm_theme";
    #| /\ /\ /\  END PATCHES FROM REDDIT  /\ /\ /\ 

    programs.hyprland = {
        enable  = yes; # check '!' comment 
        xwayland.enable = yes;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland
    environment.systemPackages = with pkgs; [ 
        ( waybar.overrideAttrs (
            #! if waybar is not installed add a seprate 'waybar' in this list.
            # this is because I don't know if this override also adds the package.
            oldAttrs : { 
                mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; 
            })
        )
        #| \/ \/ \/ BEGIN PATCHES FROM REDDIT \/ \/ \/ 
        #` below patches from: id=FRDyE5PUJj
        hyprland
        xwayland
        wayland-protocols
        wayland-utils
        wayland
        #` below patches from: id=fM7Zqy5uak 
        where-is-my-sddm-theme
        #| /\ /\ /\  END PATCHES FROM REDDIT  /\ /\ /\ 
        dunst           # Notifications 
        eww             # 
        libnotify       # Dependancy from 'dunst'.
        rofi-wayland    # Application launcher know as 'rofi', this is the wayland version.
        kitty           # The terminal Hyperland assumes you use.
        
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Programs for wallpapers ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
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

    # xdg.portal = {
    #     enable = yes;
    #     extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    # };

    sound.enable = yes;
    security.rtkit.enable = yes;
    services.pipewire = {
        enable            = yes;
        alsa.enable       = yes;
        alsa.support32Bit = yes;
        pulse.enable      = yes;
    };


#! NVIDIA needs some patches. These are the patches in question:
} // ( if ( builtins.isAttrs machine-settings.modules.nvidia ) then ({ # We only load these if the NVIDIA module is loaded. 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ START NVIDIA PATCHES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

    #|id=FRDyE5PUJj| \/ \/ \/ BEGIN PATCHES FROM REDDIT \/ \/ \/ 
    services.xserver.videoDrivers = [ "nvidia" ];
    #|id=FRDyE5PUJj| /\ /\ /\  END PATCHES FROM REDDIT  /\ /\ /\ 

    programs.hyprland.enableNvidiaPatches = yes;
    
    # in case you have an invisible cursor:
    # FIXME : When you enable this setting you stop having the program 'Hyprland', 'hyprctl' etc installed.
    #environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ END NVIDIA PATCHES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
}) else {} ) )
