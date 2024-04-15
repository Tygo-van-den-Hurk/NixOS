## Defines miscellaneous settings.

{ config, pkgs, lib, ... } : { sound = {
        enable = lib.mkDefault true;
    };
}