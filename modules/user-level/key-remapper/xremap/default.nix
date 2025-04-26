# this module enables xremap as a service.

arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    # For enableing the setting
    gui = "x11"; # TODO : make dynamic

    # the username of the person who is going to use it.
    userName = "tygo"; # TODO : make dynamic

in builtins.trace "(System) Loading: ${toString ./.}..." {

  imports = [ input.xremap.nixosModules.default ];

  services.xremap = ({
      
    serviceMode = "system";
    inherit userName;
    yamlConfig  = (builtins.readFile ./config.yml );

  } // ( 
      
    # settings can be found here: https://github.com/xremap/nix-flake/blob/master/docs/HOWTO.md
      
    if ( gui == "none"    ) then ({                     }) else 
    if ( gui == "wayland" ) then ({ withWlroots = true; }) else 
    if ( gui == "gnome"   ) then ({ withGnome = true;   }) else
    if ( gui == "kde"     ) then ({ withKDE = true;     }) else
    if ( gui == "x11"     ) then ({ withX11 = true;     }) else 
    abort (
        "The key-remapper/xremap module relies on the GUI module. " +
        "To function the xremapper module needs to enable a setting based on the GUI. " +
        "The GUI provided (${gui}) was not reconised by the xremapper module. " +
        "To fix this, either edit the xremapper module, or disable it entirely. "
    )

  ));

  hardware.uinput.enable = true;

  users.groups.uinput.members = [ userName ];
  users.groups.input.members  = [ userName ];

}
# }) else {} )
