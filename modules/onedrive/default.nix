## This module enables onedrive on the system https://nixos.wiki/wiki/OneDrive

arguments @ { config, pkgs, lib, machine-settings, ... } : let 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    yes = builtins.trace "Loading: ${toString ./.}..." true; 
    # TODO : make this this variable assigned by `builtins.trace` is used.

in {

    services.onedrive.enable = true;

}
