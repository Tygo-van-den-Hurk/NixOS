## Defines display manager / window manager settings.

{ config, pkgs, lib, ... } : { security.sudo = {
        wheelNeedsPassword = lib.mkDefault false;
    };
}

