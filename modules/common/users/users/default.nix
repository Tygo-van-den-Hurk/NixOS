## Defines the user options.

{ config, pkgs, lib, machine-settings, ... } : { users.users = {

        tygo = {
            #! Defines user accounts with a weak password. 
            initialPassword = lib.mkDefault "changeme"; 
            #! Don't forget to set a password with ‘passwd’.
            isNormalUser = lib.mkDefault true;
            description = lib.mkDefault "Tygo van den Hurk";
            extraGroups = lib.mkDefault [ 
                "networkmanager" # used for configuring the network
                "wheel"          # used for sudo
                "input"          # used for xmonad
                "uinput"         # used for xmonad 
                "video"          #? unknown
                "audio"          #? unknown
                "camera"         #? unknown
                "lp"             #? unknown
                "scanner"        #? unknown
                "plex"           #? unknown
            ];
            packages = with pkgs; [
                # personal packages go here...
            ];
        };

    };
}
