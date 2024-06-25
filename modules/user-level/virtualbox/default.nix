## installs virtual box, and configures the sytem to run it

arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    users-with-this-module-enabled = (lib.attrNames ( lib.attrsets.concatMapAttrs ( user-name: user-settings: 
        if user-settings.init.modules.virtualbox.enable then { "${user-name}" = user-settings; } else { }
    ) machine-settings.users ));

in ( if (builtins.length users-with-this-module-enabled) > 0 then ( builtins.trace "Loading: ${toString ./.}..." { 

    users.extraGroups.vboxusers.members = users-with-this-module-enabled;

    environment.systemPackages = [ pkgs.virtualboxWithExtpack ];
    virtualisation.virtualbox.host = {
        enable = true;
        enableExtensionPack = true;
    };

}) else {} )
