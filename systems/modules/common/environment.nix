## Defines environment settings.

{ config, pkgs, lib, ... } : { environment = {
        variables = {
            # TERMINAL = "";
            EDITOR = "code";
            VISUAL = "code";
        }; 
    }; 
}
