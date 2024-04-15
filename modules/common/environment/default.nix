## Defines environment settings.

{ config, pkgs, lib, ... } : { environment = {
    }; 

    imports = [
        ./systemPackages
        ./variables
    ];
}
