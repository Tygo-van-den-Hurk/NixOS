## imports all the modules in this directory as specified by the machine-settings.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    dont-load-that-module = { }; # Explanation of a constant
    __modules_ = machine-settings.modules;

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    modules = builtins.trace ( "Loading: ${toString ./.}..." ) ( __modules_ // {
        gui          = ( builtins.isString  __modules_.gui            );
        java         = ( builtins.isString  __modules_.java           );
        key-remapper = ( builtins.isString  __modules_.key-remapper   );
        nfs          = ( builtins.isAttrs   __modules_.nfs         );
    }); 

in { imports = [ 

        #| modules to load depending on wether or not they're enabled
        ( if ( modules.gaming       ) then ( import ./gaming       arguments ) else ( dont-load-that-module ) )
        ( if ( modules.onedrive     ) then ( import ./onedrive     arguments ) else ( dont-load-that-module ) )
        ( if ( modules.virtualbox   ) then ( import ./virtualbox   arguments ) else ( dont-load-that-module ) )
        ( if ( modules.openssh      ) then ( import ./openssh      arguments ) else ( dont-load-that-module ) )
        ( if ( modules.docker       ) then ( import ./docker       arguments ) else ( dont-load-that-module ) )

        #| Modules to load a sub module from
        ( if ( modules.gui          ) then ( import ./gui          arguments ) else ( dont-load-that-module ) )
        ( if ( modules.key-remapper ) then ( import ./key-remapper arguments ) else ( dont-load-that-module ) )
        ( if ( modules.java         ) then ( import ./java         arguments ) else ( dont-load-that-module ) )
        ( if ( modules.nfs          ) then ( import ./nfs          arguments ) else ( dont-load-that-module ) )

        #| modules to always load
        ./system-level
        # ( import ./user-level     )
        ./common
    ];
}
  