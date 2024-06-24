## Loads the settings needed for a WSL system.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    module-settings = machine-settings.system.modules.wsl; 

in ( if module-settings.enable == true then builtins.trace "Loading: ${toString ./.}..." {

    wsl.enable = true;
    wsl.defaultUser = module-settings.defaultUser;

} else {} )
