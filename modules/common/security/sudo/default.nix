## Defines display manager / window manager settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 
    
    security.sudo = {
        wheelNeedsPassword = lib.mkDefault false;
    };
})

