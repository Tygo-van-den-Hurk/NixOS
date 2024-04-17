## Defines the networking options.

arguments @ { config, pkgs, lib, machine-settings, ... } : { networking = {
        hostName = machine-settings.system.hostname;
    };

    imports = [
        ( import  ./firewall        arguments )
        ( import  ./networkmanager  arguments )
        ( import  ./proxy           arguments )
        ( import  ./wireless        arguments )
    ];
}
