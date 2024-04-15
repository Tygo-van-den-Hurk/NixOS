## impors all the modules in this directory.

{ config, pkgs, lib, ... } : { imports = [ 
        ./boot
        ./environment
        ./hardware
        ./i18n
        ./networking
        ./nix
        ./nixpkgs
        ./security
        ./services
        ./sound
        ./system
        ./time
        ./users
    ];
}
