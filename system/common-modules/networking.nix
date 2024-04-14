## Defines the networking options.

{ config, pkgs, lib, ... } : { networking = {

        hostName = "undefined";

        networkmanager.enable = true;

        # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

        # proxy.default = "http://user:password@proxy:port/";
        # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

        firewall.enable = true;
        firewall.allowedTCPPorts = [ ];
        firewall.allowedUDPPorts = [ ];
    };
}
