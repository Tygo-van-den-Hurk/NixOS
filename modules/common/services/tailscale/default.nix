## Defines the tailscale service.

arguments @ { config, pkgs, lib, machine-settings, ... } : { services.tailscale = {
        enable = true;
    };
}
