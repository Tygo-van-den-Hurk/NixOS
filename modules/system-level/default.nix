## imports all the system level modules in this directory as specified by the machine-settings.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 
    
    imports = [
        ./gaming 
        ./local-ai 
        ./nvidia 
        ./onedrive
        ./podman 
        ./openssh
        ./power-efficiency 
        ./wsl 
    ]; 

})
