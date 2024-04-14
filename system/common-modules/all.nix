## impors all the modules in this directory.

{ config, pkgs, lib, ... } : { imports = [ 
        ./bootloader.nix
        ./networking.nix
        ./packages.nix
        ./services.nix
        ./timezone.nix
        ./user.nix
    ];
}
