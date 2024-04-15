## Defines nix settings.

{ config, pkgs, lib, ... } : { nix.settings.experimental-features = lib.mkForce [
        "nix-command"  #? unknown 
        "flakes"       # Used to add flake support 
    ];
}
