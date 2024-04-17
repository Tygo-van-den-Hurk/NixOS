## Defines nix settings.

{ config, pkgs, lib, machine-settings, ... } : { nix.settings.experimental-features = lib.mkForce [
        "nix-command"  #? unknown 
        "flakes"       # Used to add flake support 
    ];
}
