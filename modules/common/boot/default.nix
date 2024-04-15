## Defines all the settings for boot.

{ config, pkgs, lib, ... } : { boot = {
    };
    
    imports = [ 
        ./loader 
    ];
}