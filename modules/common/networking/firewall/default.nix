## Defines the networking options.
#! Warning editing this will edit it for all hosts. Please edit this in the person configs of the systems you want this to take effect. 
{ config, pkgs, lib, ... } : { networking.firewall = {
        enable = lib.mkDefault true;         # did you read the comment?
        allowedTCPPorts = lib.mkDefault [ ]; # did you read the comment?
        allowedUDPPorts = lib.mkDefault [ ]; # did you read the comment?
    };
}
