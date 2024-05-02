arguments @ { input, machine-settings, ... } :

let 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    config = ( builtins.trace ("Loading: /modules/key-remapper/xremap...") ( builtins.readFile ./config.yml ) ); 

    #// path-to-config = /home/${machine-settings.user.username}/.config/xremap/config;

in { imports = [ input.xremap-flake.nixosModules.default ];

    hardware.uinput.enable = true;

    users.groups.uinput.members = [ machine-settings.user.username ];
    users.groups.input.members  = [ machine-settings.user.username ];

    services.xremap = {
        withWlroots = true; # TODO : Figure out what EXACTLY this setting does.
        # withHypr  = true;
        userName    = machine-settings.user.username;
        yamlConfig  = (config);
    };
}
