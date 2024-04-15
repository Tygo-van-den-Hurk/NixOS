## Defines display manager / window manager settings.

{ config, pkgs, lib, ... } : { security = {

        #? unknown was here when I booted.
        rtkit.enable = lib.mkDefault true;

        # Removes the need to enter a password when using sudo.
        sudo.wheelNeedsPassword = lib.mkDefault false;
    };
}

