## Defines the user options.

{ config, pkgs, lib, ... } : { users.users = {

        tygo = {
            #! Defines user accounts with a weak password. 
            initialPassword = "changeme"; 
            #! Don't forget to set a password with ‘passwd’.
            isNormalUser = true;
            description = "Tygo van den Hurk";
            extraGroups = [ 
                "networkmanager" # used for configuring the network
                "wheel"          # used for sudo
                "input"          # used for xmonad
                "uinput"         # used for xmonad 
                "video"          #? unknown
                "audio"          #? unknown
                "lp"             #? unknown
                "scanner"        #? unknown
            ];
            packages = with pkgs; [
                # personal packages go here...
            ];
        };

    };
}
