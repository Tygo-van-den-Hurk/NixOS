## Defines the printing service that runs on the system.

{ config, pkgs, lib, machine-settings, ... } : { services.printing = {
        enable = true;
    };
}
