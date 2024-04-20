## imports all the modules in this directory as specified by the machine-settings.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    
    dont-load-that-module = {}; 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    modules = builtins.trace ("Loading: /modules...") (machine-settings.modules); 

in { imports = [ 

        #| modules to load depending on settings
        ( if ( modules.gaming   ) then ( import ./gaming   arguments ) else ( dont-load-that-module ) )
        ( if ( modules.nvidia   ) then ( import ./nvidia   arguments ) else ( dont-load-that-module ) )
        ( if ( modules.kmonad   ) then ( import ./kmonad   arguments ) else ( dont-load-that-module ) )
        ( if ( modules.onedrive ) then ( import ./onedrive arguments ) else ( dont-load-that-module ) )

        #| modules to always load
        ( import ./common arguments ) # always import the common modules as that is required to function.
        ( import ./gui    arguments ) # always import the GUI module as that handles the logic of which gui to load.

    ];
}
 