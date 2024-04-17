## Changes settings to enable kmonad on this system.
#! Follow the guide at: https://github.com/kmonad/kmonad/blob/master/doc/installation.md#nixos when making changes.
arguments @ { config, pkgs, lib, machine-settings, ... } : 

#| 1) Import kmonad.nix into your configuration.nix file using a let expression:
let kmonad = import ./kmonad.nix; in {
    
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
