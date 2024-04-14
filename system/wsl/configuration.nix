## Defines the configuration for NixOS for the Windows Subsystem for Linux.

{ config, pkgs, lib, ... } : {

    imports = [ 
        ./../common-modules/all.nix 
        # ./hardware-configurations.nix #? I don't know how this works for WSL.
    ];

    networking.hostName = "tygos-wsl";
}
