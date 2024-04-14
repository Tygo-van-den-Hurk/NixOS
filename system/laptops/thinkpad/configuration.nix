## Defines the configuration options for my Lenovo Thinkpad laptop.

{ config, pkgs, lib, ... } : {

    imports = [ 
        ./../../common-modules/all.nix 
        ./hardware-configurations.nix 
    ];

    networking.hostName = "tygos-thinkpad";
}
