## imports all the user level modules in this directory as specified by the machine-settings.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    dont-load-that-module = { }; # Explanation of a constant
    __user-level-modules_ = null; 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    modules = builtins.trace ( "Loading: /modules..." ) ( __user-level-modules_ // {
        # todo : go over all modules of users to see if it's enabled.
    }); 

in { imports = [ 

    ];
}
  