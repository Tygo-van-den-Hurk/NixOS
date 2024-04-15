## Defines display manager / window manager settings.
#? unknown setting, but was here when I booted.
{ config, pkgs, lib, ... } : { security.rtkit = {
        enable = lib.mkDefault true;
    };
}

