## Defines the user options.

{ config, pkgs, lib, machine-settings, ... } : { users = {
    };

    imports = [
        ./users
    ];
}
