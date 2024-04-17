## Defines environment settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : { environment.variables = {
        # TERMINAL = "";
        EDITOR = "code";
        VISUAL = "code";
    }; 
}
