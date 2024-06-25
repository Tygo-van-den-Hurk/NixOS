## imports all the modules in this directory as specified by the machine-settings.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 

in { 
    
    imports = [ 
        ./system-level
        ./user-level
        ./common

        #| Modules to load a sub module from
        ( import ./gui          arguments )
        ( import ./key-remapper arguments )
    ];
}
  