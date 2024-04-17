## Defines environment settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : { environment.variables = {
        EDITOR   = machine-settings.user.defaultApps.editor;
        VISUAL   = machine-settings.user.defaultApps.editor;
        TERMINAL = machine-settings.user.defaultApps.terminal;
    }; 
}
