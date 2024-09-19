## Defines the networking options.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "(System) Loading: ${toString ./.}..." { 

    networking.wireless = {
        #// enable = (lib.mkDefault true);
    };

})
