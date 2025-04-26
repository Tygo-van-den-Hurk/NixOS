## Defines nix settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : {

    imports = [ ./settings ./gc ];
    
}
