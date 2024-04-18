## Changes settings to enable nvidia GPU's on this system.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    _ = builtins.trace "Loading: /modules/nvidia..." {}; 
    # TODO : make this this variable assigned by `builtins.trace` is used.

in {
    # I have figured out what I need to do for this yet...
}
