## Defines the configuration for NixOS as a Virtual Machine.

{ config, pkgs, lib, ... } : {

    imports = [ 
        ./../../modules/common 
        # ./hardware-configurations.nix #? I don't know how this works for virtual machines.
    ];

    networking.hostName = "tygos-nixos-vm";
}
