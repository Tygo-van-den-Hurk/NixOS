## imports all the modules in this directory as specified by the machine-settings.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
arguments @ { config, pkgs, lib, machine-settings, input, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 
 
    imports = [ 
        ./system-level
        ./user-level
        ./common
    ];

})
  