## Defines the SSH service that runs on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : { services.openssh = {
        enable = true;
    };
}
