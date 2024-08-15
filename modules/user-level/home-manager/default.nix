## Manages the users dot files

arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    users-with-this-module-enabled = (lib.attrNames ( lib.attrsets.concatMapAttrs ( user-name: user-settings: 
        if user-settings.init.modules.home-manager.enable == true then { "${user-name}" = user-settings; } else { }
    ) machine-settings.users ));

in ( if (builtins.length users-with-this-module-enabled) > 0 then ( builtins.trace "Loading: ${toString ./.}..." { 

    imports = [
        input.home-manager.nixosModules.home-manager
        input.stylix.nixosModules.stylix
    ];
    
    # stylix.enable = true;
    home-manager = {
        extraSpecialArgs = { inherit input; };

        users = let 

            user-to-home-manager-configurations = (__username_: __user_settings_: 
                (if (__user_settings_.init.modules.home-manager.enable == true) then {
                    "${__username_}" = (
                        import ((toString ./.) + "/${__user_settings_.init.modules.home-manager.configPath}") (
                            arguments
                        )
                    );
                } else {})
            );

            # The users home-manager configurations
            home-manager-configurations = ((
                lib.attrsets.concatMapAttrs user-to-home-manager-configurations machine-settings.users
            ));

        in (
            builtins.trace "Home-Manager configurations: ${builtins.toJSON (builtins.attrNames home-manager-configurations)}..." 
            home-manager-configurations
        );
    };

}) else {} )
