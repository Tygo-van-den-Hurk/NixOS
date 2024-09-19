## Defines the pipewire service.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "(System) Loading: ${toString ./.}..." { 
    
    services.pipewire = {
        enable            = true;
        alsa.enable       = true;
        alsa.support32Bit = true;
        pulse.enable      = true;
    };

})
