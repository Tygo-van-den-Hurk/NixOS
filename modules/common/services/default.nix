## Defines the services that run on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    arguments_ = builtins.trace "Loading: /modules/common/services..." arguments; 

in { imports = [ 
        ( import ./pipewire  arguments_ )
        ( import ./printing  arguments_ )
        ( import ./tailscale arguments_ )
    ]; 
}
