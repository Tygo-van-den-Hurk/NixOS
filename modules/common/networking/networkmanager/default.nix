## Defines the network manager options.

{ config, pkgs, lib, machine-settings, ... } : { networking.networkmanager = {
        enable = lib.mkDefault true;
    };
}
