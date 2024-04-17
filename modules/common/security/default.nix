## Defines display manager / window manager settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : {security = {
    };

    imports = [
        ( import ./rtkit arguments )
        ( import ./sudo  arguments )
    ];
}

