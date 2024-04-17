## imports all the modules in this directory as specified by the machine-settings.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
arguments @ { config, pkgs, lib, machine-settings, ... } : let dont-load-that-module = {}; in { imports = [ 
        ( import ./common arguments ) # always import the common modules as that is required to function. 
        ( if ( machine-settings.modules.gaming ) then ( import ./gaming arguments ) else ( dont-load-that-module ) )
        ( if ( machine-settings.modules.nvidia ) then ( import ./nvidia arguments ) else ( dont-load-that-module ) )
        ( if ( machine-settings.modules.kmonad ) then ( import ./kmonad arguments ) else ( dont-load-that-module ) )
    ];
}
 