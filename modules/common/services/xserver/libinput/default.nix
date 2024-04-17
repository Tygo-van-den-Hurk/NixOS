## Defines the settings for libinput.

arguments @ { config, pkgs, lib, machine-settings, ... } : { services.xserver.libinput = {
        enable = true; # Enable touchpad support (enabled default in most desktopManager).
    };
}
