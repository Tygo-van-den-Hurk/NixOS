## Defines the network manager options.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "(System) Loading: ${toString ./.}..." { 
    
    networking.networkmanager = {
        enable = (lib.mkDefault true);
    };
})
