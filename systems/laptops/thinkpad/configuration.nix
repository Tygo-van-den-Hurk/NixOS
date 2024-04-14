## Defines the configuration options for my Lenovo Thinkpad laptop.

{ config, pkgs, lib, ... } : {

    imports = [ 
        ./../../modules/common/all.nix 
        ./hardware-configuration.nix 
    ];

    networking.hostName = "tygos-thinkpad";
}
