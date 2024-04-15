## Defines the networking options.

{ config, pkgs, lib, ... } : { networking = {

        #` Network Manager
        networkmanager.enable = lib.mkDefault true;

        #` Hostname
        # should be over written by whatever system you're using.
        hostName = lib.mkDefault "undefined";

        #` Wireless
        # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

        #` Proxy Rules
        # proxy.default = "http://user:password@proxy:port/";
        # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

        #` Firewall Rules
        #! Warning editing this will edit it for all hosts. 
        #! Please edit this in the person configs of the 
        #! systems you want this to take effect. 
        firewall.enable = lib.mkDefault true;         # did you read the comment?
        firewall.allowedTCPPorts = lib.mkDefault [ ]; # did you read the comment?
        firewall.allowedUDPPorts = lib.mkDefault [ ]; # did you read the comment?
    };
}
