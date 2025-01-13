## Defines the services that run on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "(System) Loading: ${toString ./.}..." { 

    imports = [ ./espanso ./libinput ./logind ./pipewire ./printing ./tailscale ]; 
    
})
