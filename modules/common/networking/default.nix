## Defines the networking options.

{ config, pkgs, lib, ... } : { networking = {
        hostName = lib.mkDefault "undefined-because-flake-did-not-overwrite-this";
    };

    imports = [
        ./firewall
        ./networkmanager
        ./proxy
        ./wireless
    ];
}
