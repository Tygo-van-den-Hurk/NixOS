## Defines the settings for the timezone.

{ config, pkgs, lib, machine-settings, ... } : { time = {
        timeZone = lib.mkDefault "Europe/Amsterdam";
    };
}
