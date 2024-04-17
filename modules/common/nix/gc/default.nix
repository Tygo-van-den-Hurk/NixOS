## Defines nix garbage collection settings.

{ config, pkgs, lib, machine-settings, ... } : { nix.gc = {
        automatic = true;
        dates =  "weekly";
        options = "--delete-older-than 7d";
    };
}
