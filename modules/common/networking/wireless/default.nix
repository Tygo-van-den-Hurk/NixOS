## Defines the networking options.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 

    networking.wireless = {
        #// enable = (lib.mkDefault true);
    };

})
