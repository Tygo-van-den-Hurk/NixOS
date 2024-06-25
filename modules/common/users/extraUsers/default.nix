## Defines the user options.
arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 

    # TODO : make all the users get printed to the console
    users.extraUsers = ( lib.attrsets.concatMapAttrs (__username_: __usersettings_:  
        # remove attributes that Nix does not reconise
        { "${__username_}" = builtins.removeAttrs __usersettings_ [ "init" ]; }
    ) machine-settings.users);
    
})
