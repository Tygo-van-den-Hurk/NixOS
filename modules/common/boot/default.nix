## Defines all the settings for boot.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "(System) Loading: ${toString ./.}..." { 

    imports = [ ./loader ];
    
})
