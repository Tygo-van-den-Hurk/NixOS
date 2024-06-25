## Defines the systems auto upgrade settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 
    
    system.autoUpgrade = { 
        enable = lib.mkDefault true;
    };

})
