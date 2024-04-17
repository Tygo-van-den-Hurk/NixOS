## Defines display manager / window manager settings.

{ config, pkgs, lib, machine-settings, ... } : { security.sudo = {
        wheelNeedsPassword = lib.mkDefault false;
    };
}

