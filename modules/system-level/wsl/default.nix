## Loads the settings needed for a WSL system.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    wsl-settings = (builtins.trace 
        "Loading: /modules/system-level/wsl/..." 
        machine-settings.system.modules.wsl
    ); 

in {
    wsl.enable = wsl-settings.enable;
    wsl.defaultUser = wsl-settings.defaultUser;
}
  