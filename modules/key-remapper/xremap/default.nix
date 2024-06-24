arguments @ { input, machine-settings, ... } :

let 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    config = ( builtins.trace "xremap with gui support for: ${__gui_}" (
            builtins.trace "Loading: ${toString ./.}..." (builtins.readFile ./config.yml)
        ) 
    ); 

    # For enableing the setting
    __gui_ = machine-settings.modules.gui;
    gui = ( 
        if (__gui_ == ""      || __gui_ == null       || __gui_ == false       ) then ( "none"    ) else 
        if (__gui_ == "sway"  || __gui_ == "hyprland" || __gui_ == "hyperland" ) then ( "wayland" ) else 
        if (__gui_ == "kde"   || __gui_ == "KDE"                               ) then ( "kde"     ) else 
        if (__gui_ == "gnome" || __gui_ == "GNOME"                             ) then ( "gnome"   ) else 
        if (__gui_ == "i3wm"  || __gui_ == "i3"                                ) then ( "x11"   ) else 
        (__gui_) 
    );

    # In case of failure
    abort_message =  (
        "The key-remapper/xremap module relies on the GUI module. " +
        "To function the xremapper module needs to enable a setting based on the GUI. " +
        "The GUI provided (${__gui_}) was not reconised by the xremapper module. " +
        "To fix this, either edit the xremapper module, or disable it entirely. "
    );

    # the username of the person who is going to use it.
    userName = machine-settings.users.primary-user.name;

in { imports = [ input.xremap-flake.nixosModules.default ];

    services.xremap = ({
        
        serviceMode = "system";
        inherit userName;
        yamlConfig  = (config);

    } // ( 
        
        # settings can be found here: https://github.com/xremap/nix-flake/blob/master/docs/HOWTO.md
        
        if ( gui == "none"    ) then ({                     }) else 
        if ( gui == "wayland" ) then ({ withWlroots = true; }) else 
        if ( gui == "gnome"   ) then ({ withGnome = true;   }) else
        if ( gui == "kde"     ) then ({ withKDE = true;     }) else
        if ( gui == "x11"     ) then ({ withX11 = true;     }) else 
        abort abort_message

    ));

    hardware.uinput.enable = true;

    users.groups.uinput.members = [ userName ];
    users.groups.input.members  = [ userName ];
}
