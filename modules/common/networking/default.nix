## Defines the networking options.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "(System) Loading: ${toString ./.}..." { 
     
    imports = [ ./firewall ./networkmanager ./proxy ./wireless ]; 
    
    networking = {
        hostName = (lib.mkDefault machine-settings.system.hostname);
    };

})
