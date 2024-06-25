## installs virtual box, and configures the sytem to run it

arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    users-with-this-module-enabled = (lib.attrNames ( lib.attrsets.concatMapAttrs ( user-name: user-settings: 
        if user-settings.init.modules.docker.enable then { "${user-name}" = user-settings; } else { }
    ) machine-settings.users ));

in ( if (builtins.length users-with-this-module-enabled) > 0 then ( builtins.trace "Loading: ${toString ./.}..." { 

    users.extraGroups.docker.members = users-with-this-module-enabled;

    environment.systemPackages = with pkgs; [
        docker
        docker-compose
    ];

    virtualisation.docker = {
        enable = true;    
        rootless = {
            enable = true;
            setSocketVariable = true;
        };
    };

}) else {} )
