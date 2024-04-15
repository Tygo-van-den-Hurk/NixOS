## Defines the SSH service that runs on the system.

{ config, pkgs, lib, ... } : { services.openssh = {
        enable = true;
    };
}
