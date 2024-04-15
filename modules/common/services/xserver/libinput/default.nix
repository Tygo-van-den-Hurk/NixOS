## Defines the settings for libinput.

{ config, pkgs, lib, ... } : { services.xserver.libinput = {
        enable = true; # Enable touchpad support (enabled default in most desktopManager).
    };
}
