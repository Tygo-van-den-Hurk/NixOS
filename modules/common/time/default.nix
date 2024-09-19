## Defines the settings for the timezone.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "(System) Loading: ${toString ./.}..." { 

    time = {
        timeZone = lib.mkDefault "Europe/Amsterdam";
    };
})
