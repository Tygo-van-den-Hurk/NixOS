## Defines the tailscale service.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "(System) Loading: ${toString ./.}..." { 
    
    services.tailscale = {
        enable = true;
    };
    
})
