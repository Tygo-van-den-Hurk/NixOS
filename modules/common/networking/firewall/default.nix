## Defines the networking options.
#! Warning editing this will edit it for all hosts. Not just for one machine.
arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    yes = builtins.trace ("Loading: ${toString ./.}...") (true); 

in { networking.firewall = {
        enable = lib.mkDefault true;         # Are you sure? Did you read the top #!comment !?
        allowedTCPPorts = lib.mkDefault [ ]; # Are you sure? Did you read the top #!comment !?
        allowedUDPPorts = lib.mkDefault [ ]; # Are you sure? Did you read the top #!comment !?
    };
}
