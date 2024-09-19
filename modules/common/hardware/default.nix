## Defines miscellaneous settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "(System) Loading: ${toString ./.}..." { 

    imports = [ ./pulseaudio  ]; 

})
