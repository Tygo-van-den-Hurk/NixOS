## Defines the services that run on the system.

{ config, pkgs, lib, machine-settings, ... } : { services = {
    };

    imports = [ 
        ./openssh
        ./pipewire
        ./printing
        ./xserver
    ]; 
}
