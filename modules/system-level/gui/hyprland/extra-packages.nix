arguments @ { config, pkgs, lib, ... } : let 

    updated-waybar = [(
        pkgs.waybar.overrideAttrs( oldAttrs : {
            mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
        })
    )];

    hyprland-basis          = with pkgs; [ hyprland xwayland wayland-protocols wayland-utils wayland ];
    application-launchers   = with pkgs; [ rofi-wayland                                              ];
    wallpaper-applications  = with pkgs; [ hyperpaper swaybg mpvpaper wpaperd swww                   ];
    notifications-providers = with pkgs; [ dunst libnotify                                           ];
    hyprland-extentions     = with pkgs; [ eww updated-waybar                                        ];
    
in ( builtins.trace "Loading: ${toString ./.} (extra packages)..." {
    
    environment.systemPackages = ( 
        hyprland-basis 
        ++ application-launchers 
        ++ wallpaper-applications 
        ++ notifications-providers 
        ++ hyprland-extentions 
        ++ 
    );

})