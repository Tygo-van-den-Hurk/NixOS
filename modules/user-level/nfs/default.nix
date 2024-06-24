## Configures NSF

arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    users = ( builtins.trace "Loading: ${toString ./.}..." machine-settings.users ); 

    nothing = { };

in
#| Filtering users, server, shares that aren't enabled and transforming them
let 
    
    shares-and-where-to-mount-them = ( builtins.attrValues (( __users_:
        ( lib.attrsets.concatMapAttrs (__username_: __usersettings_: 

            let nfs-module = __usersettings_.init.modules.nfs; in 
            if (builtins.hasAttr "enable" nfs-module && nfs-module.enable == false) then nothing 
            else ( lib.attrsets.concatMapAttrs (__server_name_: __server_settings_: 

                if (builtins.hasAttr "enable" __server_settings_ && __server_settings_.enable == false) then nothing 
                else ( lib.attrsets.concatMapAttrs (__share_name_: __share_settings_: 

                    if (builtins.hasAttr "enable" __share_settings_ && __share_settings_.enable == false) then nothing 
                    else let 
                    
                        username-string       = ( toString __username_                      );
                        servername-string     = ( toString __server_name_                   );
                        sharename-string      = ( toString __share_name_                    );
                        mountlocation-string  = ( toString __share_settings_.mount-location );

                        key = "${username-string}-${servername-string}-${sharename-string}-${mountlocation-string}";
                
                    in { 
                        "${key}" = {
                            user-name           = __username_;
                            server-name         = __server_name_;
                            share-name          = __share_name_;
                            mounting = {
                                location        = __share_settings_.mount-location;
                                options = {
                                #     automount   = __share_settings_. ;
                                #     lazymount   = __share_settings_.lazy-mount;
                                };
                            };
                        };
                    }
                ) __server_settings_.shares )
            ) nfs-module.servers )
        ) __users_ )
    ) users ));

in # shares-and-where-to-mount-them
#| converting them into a list
let

    systemd-mounts = lib.lists.forEach shares-and-where-to-mount-them ( item:
        {
            what = "${item.server-name}:/${item.share-name}";
            where = item.mounting.location;
            type = "nfs";
        } 
        # // ( if item.mounting.options.automount == false then nothing else { mountConfig.Options = "noatime"; } )
    );

    systemd-auto-mounts = lib.lists.forEach shares-and-where-to-mount-them ( item:
        {
            where = item.mounting.location;
            wantedBy = [ "multi-user.target" ];
        } 
        # // ( 
        #     if ( item.mounting.options.automount == false ) then ( nothing ) else 
        #     if ( item.mounting.options.automount == false ) then ( nothing ) else 
        #     if ( builtins.isString item.mounting.options.automount ) then { 
        #         automountConfig.TimeoutIdleSec = "600"; 
        #     } else nothing
        # )
    );

in {

    services.rpcbind.enable = true; 
    systemd.mounts = systemd-mounts;
    systemd.automounts = systemd-auto-mounts;

}
