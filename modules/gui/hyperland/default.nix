## Defines Hyperland settings.
#! This is just for non-NVIDIA users. If you have an NVIDIA GPU, you must add some patches. 
arguments @ { config, pkgs, lib, machine-settings, ... } : let 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    yes = builtins.trace ("Loading: /modules/gui/hyperland...") (true); 

in { # See https://www.youtube.com/watch?v=61wGzIv12Ds
    
    programs.hyperland.enable  = yes; # check '!' comment
    environment.systemPackages = with pkgs; [ waybar eww ];

}