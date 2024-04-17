## Defines the settings for the timezone.

arguments @ { config, pkgs, lib, machine-settings, ... } : { time = {
        timeZone = lib.mkDefault "Europe/Amsterdam";
    };
}
