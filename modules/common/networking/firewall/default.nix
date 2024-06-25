## Defines the networking options.
#! Warning editing this will edit it for all hosts. Not just for one machine.
arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 
    
    networking.firewall = {
        enable          = lib.mkDefault true;   # Are you sure? Did you read the top #!comment !?
        allowedTCPPorts = lib.mkDefault [  ];   # Are you sure? Did you read the top #!comment !?
        allowedUDPPorts = lib.mkDefault [  ];   # Are you sure? Did you read the top #!comment !?
    };
    
})
