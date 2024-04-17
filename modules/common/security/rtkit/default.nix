## Defines display manager / window manager settings.
#? unknown setting, but was here when I booted.
arguments @ { config, pkgs, lib, machine-settings, ... } : { security.rtkit = {
        enable = lib.mkDefault true;
    };
}

