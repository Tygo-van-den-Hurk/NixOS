arguments @ { input, machine-settings, ... } :

let 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    yes = ( builtins.trace ("Loading: /modules/xremap...") ( true ) ); 

    path-to-config = /home/${machine-settings.user.username}/.config/xremap/config;

in { imports = [ input.xremap-flake.nixosModules.default ];

    services.xremap = {
        withWlroots = yes; # TODO : Figure out what EXACTLY this setting does.
        # withHypr  = yes;
        userName    = machine-settings.user.username;
        yamlConfig  = (''
            ## Generated from: '.../NixOS/modules/xremap/defaul.nix' at 'services.xremap.yamlConfig'.

            #| Remapping modifiers
            # this part will remap CTRL to ALT and vise vera to get the layout desired. 
            modmap:
              - name: Global Remap CTRL to ALT
                remap:
                  CONTROL_L: ALT_L
              - name: Global Remap ALT to CTRL
                remap:
                  ALT_L: CONTROL_L
            
            #| Remapping keycombinations
            # this part will be for adding custom keyboard shortcuts, or remapping to existing ones.
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