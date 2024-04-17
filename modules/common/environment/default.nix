## Defines environment settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : { environment = {
    }; 

    imports = [
        ( import ./systemPackages arguments )
        ( import ./variables      arguments )
    ];
}
