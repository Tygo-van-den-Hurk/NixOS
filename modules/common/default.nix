## impors all the modules in this directory.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "(System) Loading: ${toString ./.}..." { 
  imports = [ 
    ./boot
    ./environment
    ./fonts
    ./hardware
    ./i18n
    ./networking
    ./nix
    ./nixpkgs
    ./security
    ./services
    ./sops
    ./system
    ./time
    ./users
  ]; 
})
