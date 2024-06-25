## Defines nix settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 

    nix.settings.experimental-features = lib.mkForce [
        "nix-command"  #? unknown 
        "flakes"       # Used to add flake support 
    ];
    
})
