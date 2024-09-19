## Defines Hyperland settings.
#! This is just for non-NVIDIA users. If you have an NVIDIA GPU, you must add some patches. 
arguments @ { config, pkgs, lib, machine-settings, programs, ... } : let 

    module-settings = machine-settings.system.modules.gui.hyprland;

in ( if ( module-settings.enable == true ) then ( builtins.trace "(System) Loading: ${toString ./.}..." {

    imports = [ ./nvidia-patches.nix ./extra-packages.nix ];

    services.xserver.enable = lib.mkDefault true; 
    services.xserver.libinput.touchpad.naturalScrolling = lib.mkDefault true;
    services.xserver.displayManager.sddm.enable = lib.mkDefault true;
    services.xserver.displayManager.sddm.wayland.enable = lib.mkDefault true;

    programs.hyprland = {
        enable  = lib.mkDefault true;
        xwayland.enable = lib.mkDefault true;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = lib.mkDefault "1"; # hint electron apps to use wayland

    # xdg.portal = { # Portals
    #     enable = true;
    #     extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    # };

    sound.enable = lib.mkDefault true;
    
    security.rtkit.enable = lib.mkDefault true;

    services.pipewire = {
        enable            = lib.mkDefault true;
        alsa.enable       = lib.mkDefault true;
        alsa.support32Bit = lib.mkDefault true;
        pulse.enable      = lib.mkDefault true;
    };

}) else {} )
