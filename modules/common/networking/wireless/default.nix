## Defines the networking options.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    _ = builtins.trace "Loading: ${toString ./.}..." machine-settings; 
in { networking.wireless = {
        #// enable = true;
    };
}
