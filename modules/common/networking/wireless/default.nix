## Defines the networking options.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    _ = builtins.trace "Loading: /modules/common/networking/wireless..." machine-settings; 
in { networking.wireless = {
        #// enable = true;
    };
}
