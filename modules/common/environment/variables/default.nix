## Defines environment settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 

    environment.variables = let defaultApps = machine-settings.users.tygo.init.defaultApps; in {
        EDITOR   = ( defaultApps.editor   );
        TERMINAL = ( defaultApps.terminal );
        BROWSER  = ( defaultApps.browser  );
        VISUAL   = ( defaultApps.editor   );
    }; 

})
