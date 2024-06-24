## Enabled podman as a service.

arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    module-settings = machine-settings.system.modules.podman; 

in ( if module-settings.enable == true then builtins.trace "Loading: ${toString ./.}..." { 
        
    virtualisation = {
        containers.enable = true;
        podman = {
            enable = true;
            dockerCompat = module-settings.dockerCompat;
            defaultNetwork.settings.dns_enabled = true;
        };
    };

    environment.systemPackages = with pkgs; [
        dive
        podman-tui
        podman-compose
    ];

} else {} )
