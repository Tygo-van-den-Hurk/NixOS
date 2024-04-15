## Defines the configuration for NixOS for the Windows Subsystem for Linux.

{ config, pkgs, lib, ... } : {

    imports = [ 
        ./../../modules/common 
        # ./hardware-configurations.nix #? I don't know how this works for WSL.
    ];

    networking.hostName = "tygos-nixos-wsl";
}
