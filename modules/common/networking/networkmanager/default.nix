## Defines the network manager options.

arguments @ { config, pkgs, lib, machine-settings, ... } : { networking.networkmanager = {
        enable = lib.mkDefault true;
    };
}
