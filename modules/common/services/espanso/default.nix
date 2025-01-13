## Defines the services that run on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "(System) Loading: ${toString ./.}..." { 

    environment.systemPackages = with pkgs; [ espanso ];

    services.espanso = {
        enable = true;
    };

})
