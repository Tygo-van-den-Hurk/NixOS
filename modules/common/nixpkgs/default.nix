## Defines Nix packages configuration settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 
    
    imports = [ ./config ]; 

})
