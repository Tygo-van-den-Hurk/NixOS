## Defines miscellaneous settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 
     
    hardware.pulseaudio = {
        enable = (lib.mkDefault false);
    };

})
