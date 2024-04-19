## Defines the user options.
arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    initial-password = builtins.trace ("Loading: /modules/common/users/extraUsers...") ("changeme"); 

in { users.extraUsers = {

        tygo = {
            #! Defines user accounts with a weak password. 
            initialPassword = lib.mkDefault initial-password; 
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
