## Configures docker

arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    primary-user = builtins.trace ("Loading: ${toString ./.}...") (machine-settings.users.primary-user.name); 

in { 

    users.users.${primary-user}.extraGroups = [ "docker" ];
    virtualisation.docker = {
        enable = true;
        
        rootless = {
            enable = true;
            setSocketVariable = true;
        };
    };
}
  