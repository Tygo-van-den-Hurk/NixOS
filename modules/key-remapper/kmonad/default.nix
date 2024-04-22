## Changes settings to enable kmonad on this system.
#! Follow the guide at: https://github.com/kmonad/kmonad/blob/master/doc/installation.md#nixos when making changes.
arguments @ { config, pkgs, lib, machine-settings, ... } : let

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    kmonad-path = builtins.trace ("Loading: /modules/remapper/kmonad...") (./kmonad.nix); 

    #| 1) Import kmonad.nix into your configuration.nix file using a let expression:
    kmonad = import kmonad-path; 

in {
    
    #| 2) Add kmonad to environment.systemPackages:
    environment.systemPackages = with pkgs; [ kmonad ];

    #| 3) Create the uinput group and add your user to uinput and input:
    users.groups = { uinput = {}; };
    users.extraUsers.${machine-settings.user.username} = { extraGroups = [ "input" "uinput" ]; };

    #| 4) Add udev rules:
    services.udev.extraRules = (''
        # KMonad user access to /dev/uinput
        KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '');
}

# TODO: allow this to work in pure mode as well.
