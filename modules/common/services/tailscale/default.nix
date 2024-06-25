## Defines the tailscale service.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 
    
    services.tailscale = {
        enable = true;
    };
    
})
