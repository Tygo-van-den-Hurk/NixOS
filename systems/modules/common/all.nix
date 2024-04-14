## impors all the modules in this directory.

{ config, pkgs, lib, ... } : { imports = [ 
        ./bootloader.nix
        ./miscellaneous.nix
        ./display.nix
        ./networking.nix
        ./nix.nix
        ./packages.nix
        ./services.nix
        ./system.nix
        ./timezone.nix
        ./user.nix
    ];
}
