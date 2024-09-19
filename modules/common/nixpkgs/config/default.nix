## Defines Nix packages configuration settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "(System) Loading: ${toString ./.}..." { 
    
    nixpkgs.config = {
        allowUnfree = (lib.mkDefault machine-settings.system.packages.allowUnfree);
    };
})
