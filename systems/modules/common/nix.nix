## Defines nix settings.

{ config, pkgs, lib, ... } : { nix = {
    
        #` enabling experimental features
        settings.experimental-features = lib.mkForce [
            "nix-command"  #? unknown 
            "flakes"       # Used to add flake support 
        ];


        #` Garbage collection
        #//settings.auto-optomise-store = true;
        gc = {
            automatic = true;
            dates =  "weekly";
            options = "--delete-older-than 7d";
        };
    };
}
