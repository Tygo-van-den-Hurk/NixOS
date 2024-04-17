## Defines environment settings.

{ config, pkgs, lib, machine-settings, ... } : { environment = {
    }; 

    imports = [
        ./systemPackages
        ./variables
    ];
}
