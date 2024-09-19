## Defines display manager / window manager settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "(System) Loading: ${toString ./.}..." { 
 
    imports = [ ./rtkit ./sudo ]; 

})
