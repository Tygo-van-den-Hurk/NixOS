## Defines the SSH service that runs on the system.

{ config, pkgs, lib, machine-settings, ... } : { services.openssh = {
        enable = true;
    };
}
