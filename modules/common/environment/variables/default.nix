## Defines environment settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    defaultApps = builtins.trace ("Loading: /modules/common/environment/variables...") (
        machine-settings.user.defaultApps
    ); 

in { environment.variables = {
        EDITOR   = defaultApps.editor;
        VISUAL   = defaultApps.editor;
        TERMINAL = defaultApps.terminal;
    }; 
}
