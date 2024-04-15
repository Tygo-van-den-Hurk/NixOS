## Defines the network manager options.

{ config, pkgs, lib, ... } : { networking.networkmanager = {
        enable = lib.mkDefault true;
    };
}
