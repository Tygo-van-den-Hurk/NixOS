## Defines Nix packages configuration settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "(System) Loading: ${toString ./.}..." { 
    
    imports = [ ./config ]; 

})
