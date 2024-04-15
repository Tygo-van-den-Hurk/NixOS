## Defines the user options.

{ config, pkgs, lib, ... } : { users = {
    };

    imports = [
        ./users
    ];
}
