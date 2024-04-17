## Defines nix settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : { nix = {
    };

    imports = [
        ( import ./settings arguments )
        ( import ./gc       arguments )
    ];
}
