## This is the specific Setting file for this machine
#! Any setting you write here will overwrite whatever anyone has tried to set before.
arguments @ { config, pkgs, lib, ... } : let

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    common-settings = builtins.trace "machine-settings at /system/category:\n\t${builtins.toJSON cs_}" (cs_);
    cs_ = ( import ../common-settings.nix arguments );

in ( common-settings // { # add updates below:

    system.hostname = "tygos-thinkpad";
    system.architecture = "86x_64-linux";
})