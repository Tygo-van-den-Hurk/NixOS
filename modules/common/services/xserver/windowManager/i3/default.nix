## Defines the services that run on the system.

{ config, pkgs, lib, machine-settings, ... } : { services.xserver.windowManager.i3 = {
        enable = false;
        extraPackages = with pkgs; [
            dmenu 
            rofi
            i3status
            i3lock 
            i3blocks
        ];
    };
}
