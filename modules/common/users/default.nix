## Defines the user options.

arguments @ { config, pkgs, lib, machine-settings, ... } : { users = {
    };

    imports = [
        ( import ./extraUsers arguments )
    ];
}
