## Defines the printing service that runs on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : { services.printing = {
        enable = true;
    };
}
