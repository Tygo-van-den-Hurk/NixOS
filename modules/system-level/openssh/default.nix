## Enabled SSH as a service.

arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    module-settings = machine-settings.system.modules.openssh; 

in ( if module-settings.enable == true then builtins.trace "Loading: ${toString ./.}..." { 

    services.openssh = {
        enable = true;
        settings = { # Enhance Security
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
            openssh.settings.PermitRootLogin = "no";
        };
    };

} else {} )
