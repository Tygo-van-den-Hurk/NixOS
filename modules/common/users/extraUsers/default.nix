## Defines the user options.
arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    # __users_ 
    users = builtins.trace ("Loading: /modules/common/users/extraUsers...") (machine-settings.users.all);
    # users = let 
    
    #     all-user-names = (lib.attrNames __users_);
    #     sperator = ("\n\t - "); 
    #     all-user-names-string = (builtins.concatStringsSep sperator all-user-names);

    # in (builtins.trace
    #     "defined users:${sperator+all-user-names-string}"
    #     __users_
    # );

in {
    
    # TODO : make all the users get printed to the console
    users.extraUsers = (builtins.listToAttrs (map (user: lib.nameValuePair (user.name) (
            builtins.removeAttrs user [ "defaultApps" ] # remove attributes that Nix does not reconise
        )) 
        users
    ));
    
}
