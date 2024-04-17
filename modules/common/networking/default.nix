## Defines the networking options.

{ config, pkgs, lib, machine-settings, ... } : { networking = {
        # hostName = ( 
        #     if builtins.hasAttr "null" machine-settings.hostname then 
        #         throw "Variable 'machine-settings.hostname' is not defined." 
        #     else machine-settings.hostname 
        # );

        hostName = machine-settings.hostname;
    };

    imports = [
        ( import  ./firewall        arguments )
        ( import  ./networkmanager  arguments )
        ( import  ./proxy           arguments )
        ( import  ./wireless        arguments )
    ];
}
