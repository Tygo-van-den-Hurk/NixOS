## Defines the pipewire service.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    yes = builtins.trace ("Loading: /modules/common/services/pipewire...") (true); 

in { services.pipewire = {
        enable            = yes;
        alsa.enable       = yes;
        alsa.support32Bit = yes;
        pulse.enable      = yes;
    };
}
