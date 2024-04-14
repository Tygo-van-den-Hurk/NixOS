## Defines the user options.

{ config, pkgs, lib, ... } : { users.users = {

        #! Defines user accounts without a password. 
        #! Don't forget to set a password with ‘passwd’.

        tygo = {
            isNormalUser = true;
            description = "Tygo van den Hurk";
            extraGroups = [ 
                "networkmanager" 
                "wheel"  # used for sudo
                "input"  # used for xmonad
                "uinput" # used for xmonad 
            ];
            packages = with pkgs; [
                # personal packages go here...
            ];
        };

    };
}
