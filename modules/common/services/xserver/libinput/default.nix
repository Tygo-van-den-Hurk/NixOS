## Defines the settings for libinput.

{ config, pkgs, lib, machine-settings, ... } : { services.xserver.libinput = {
        enable = true; # Enable touchpad support (enabled default in most desktopManager).
    };
}
