# this module enables xremap as a service.

arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    config = ( builtins.readFile ./config.yml ); 

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
    userName = "tygo"; # TODO : make dynamic

# in ( if machine-settings.modules.keyre then ( builtins.trace "Loading: ${toString ./.}..." { 
in {

    imports = [ input.xremap-flake.nixosModules.default ];

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
# }) else {} )
