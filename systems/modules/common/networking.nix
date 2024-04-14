## Defines the networking options.

{ config, pkgs, lib, ... } : { networking = {

        #` Network Manager
        networkmanager.enable = true;

        #` Hostname
        # should be over written by whatever system you're using.
        hostName = lib.mkDefault "undefined";

        #` Wireless
        # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

        #` Proxy Rules
        # proxy.default = "http://user:password@proxy:port/";
        # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

        #` Firewall Rules
        firewall.enable = true;
        firewall.allowedTCPPorts = [ ];
        firewall.allowedUDPPorts = [ ];
    };
}
