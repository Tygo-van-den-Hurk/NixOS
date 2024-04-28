## imports all the modules in this directory as specified by the machine-settings.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    dont-load-that-module = {}; 
    __modules_ = machine-settings.modules;

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    modules = builtins.trace ("Loading: /modules...") (__modules_ // {
        nvidia       = ((__modules_.nvidia       != null ) && ( __modules_.nvidia       !=""  ) && ( __modules_.nvidia       != false ));
        gui          = ((__modules_.gui          != null ) && ( __modules_.gui          != "" ) && ( __modules_.gui          != false ));
        java         = ((__modules_.java         != null ) && ( __modules_.java         != "" ) && ( __modules_.java         != false ));
        key-remapper = ((__modules_.key-remapper != null ) && ( __modules_.key-remapper != "" ) && ( __modules_.key-remapper != false ));
    }); 

in { imports = [ 

        #| modules to load depending on settings
        ( if ( modules.gaming       ) then ( import ./gaming       arguments ) else ( dont-load-that-module ) )
        ( if ( modules.nvidia       ) then ( import ./nvidia       arguments ) else ( dont-load-that-module ) )
        ( if ( modules.onedrive     ) then ( import ./onedrive     arguments ) else ( dont-load-that-module ) )
        ( if ( modules.virtualbox   ) then ( import ./virtualbox   arguments ) else ( dont-load-that-module ) )
        ( if ( modules.java         ) then ( import ./java         arguments ) else ( dont-load-that-module ) )
        ( if ( modules.gui          ) then ( import ./gui          arguments ) else ( dont-load-that-module ) )
        ( if ( modules.key-remapper ) then ( import ./key-remapper arguments ) else ( dont-load-that-module ) )

        #| modules to always load
        ( import ./common       arguments ) # always import the common modules as that is required to function.
    ];
}
  