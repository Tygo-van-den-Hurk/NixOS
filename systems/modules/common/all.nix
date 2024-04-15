## impors all the modules in this directory.

{ config, pkgs, lib, ... } : { imports = [ 
        ./bootloader.nix
        ./miscellaneous.nix
        ./display.nix
        ./environment.nix
        ./internationalisation.nix
        ./networking.nix
        ./nix.nix
        ./packages.nix
        ./security.nix
        ./services.nix
        ./system.nix
        ./timezone.nix
        ./user.nix
    ];
}
