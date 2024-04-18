## Defines the services that run on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    
    arguments_ = builtins.trace "Loading: /modules/common/services..." arguments; 

in { services = { };

    imports = [ 
        ( import ./openssh   arguments_ )
        ( import ./pipewire  arguments_ )
        ( import ./printing  arguments_ )
        ( import ./tailscale arguments_ )
        #// ( import ./xserver   arguments )
    ]; 
}
