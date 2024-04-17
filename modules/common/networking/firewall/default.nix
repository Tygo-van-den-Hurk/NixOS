## Defines the networking options.
#! Warning editing this will edit it for all hosts. Not just for one machine.
arguments @ { config, pkgs, lib, machine-settings, ... } : { networking.firewall = {
        enable = lib.mkDefault true;         # did you read the comment?
        allowedTCPPorts = lib.mkDefault [ ]; # did you read the comment?
        allowedUDPPorts = lib.mkDefault [ ]; # did you read the comment?
    };
}
