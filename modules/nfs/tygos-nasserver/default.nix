## installs virtual box, and configures the sytem to run it

arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    tygos-nasserver = builtins.trace ("Loading: /modules/nfs/tygos-nasserver...") ("tygos-nasserver.tail9fcea.ts.net"); 

in 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DEFINING THE NSF OPTIONS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
let 

    one_second  = ( 1               ); 
    one_minute  = ( 60 * one_second );
    ten_minutes = ( 10 * one_minute );

    auto-UNMOUNT = [ "x-systemd.idle-timeout=${ten_minutes}" ];
    NO-automount = [ "x-systemd.automount" "noauto" ];
    
    options = ( NO-automount ++ auto-UNMOUNT ); 

in 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ADDING THE NFS SHARES TO THE CONFIG ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
{ 
    
    fileSystems = (builtins.listToAttrs (map (mounted-share: lib.nameValuePair 
            ( "/mnt/${tygos-nasserver}/${mounted-share}" ) 
            {
                device = "${tygos-nasserver}:/${mounted-share}";
                fsType = "nfs";
                inherit options;
            }
        ) 
        machine-settings.modules.nfs.tygos-nasserver
    ));

}
