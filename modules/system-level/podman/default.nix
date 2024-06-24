## Enabled podman as a service.

arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    module-settings = (builtins.trace "Loading: ${toString ./}..." machine-settings.system.modules.podman ); 

in ( if module-settings.enable == true then { 
        
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
