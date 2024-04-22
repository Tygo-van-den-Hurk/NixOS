arguments @ { input, machine-settings, ... } :

let 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    yes = ( builtins.trace ("Loading: /modules/xremap...") ( true ) ); 

    path-to-config = /home/${machine-settings.user.username}/.config/xremap/config;

in 

# assert ( builtins.pathExists path-to-config );

{

    imports = [ input.xremap-flake.nixosModules.default ];

    services.xremap = {
        withWlroots = yes;
        # withHypr  = yes;
        userName    = machine-settings.user.username;
        yamlConfig  = (''
            # modmap:
            #   - name: Global
            #     remap:
            #       CapsLock: Esc
            # keymap:
            #   - name: general keybindings
            #       mode: default
            #       remap:
            #         super-y:
            #           launch: [ "firefox" ]
        '');
    };

    hardware.uinput.enable = yes;

    users.groups.uinput.members = [ machine-settings.user.username ];
    users.groups.input.members  = [ machine-settings.user.username ];
}