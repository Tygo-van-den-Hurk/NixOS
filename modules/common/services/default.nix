## Defines the services that run on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : {services = {
    };

    imports = [ 
        ( import ./openssh   arguments )
        ( import ./pipewire  arguments )
        ( import ./printing  arguments )
        ( import ./tailscale arguments )
        ( import ./xserver   arguments )
    ]; 
}
