## Defines nix garbage collection settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 

    nix.gc = {
        automatic = (lib.mkDefault true);
        dates     = (lib.mkDefault "weekly");
        options   = (lib.mkDefault "--delete-older-than 30d");
    };

})
