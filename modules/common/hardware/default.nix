## Defines miscellaneous settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 

    imports = [ ./pulseaudio  ]; 

})
