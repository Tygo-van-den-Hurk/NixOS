## Defines the services that run on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 

    imports = [ ./libinput ./logind ./pipewire ./printing ./tailscale ]; 
    
})
