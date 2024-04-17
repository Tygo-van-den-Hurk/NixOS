## Defines all the settings for boot.

arguments @ { config, pkgs, lib, machine-settings, ... } : { boot = {
    };
    
    imports = [ 
        ( import  ./loader  arguments )
    ];
}