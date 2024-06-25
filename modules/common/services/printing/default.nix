## Defines the printing service that runs on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 
 
    services.printing = {
        enable = true;
    };

})
