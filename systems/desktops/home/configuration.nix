## Defines the configuration options for my Lenovo Thinkpad laptop.

{ config, pkgs, lib, ... } : {

    imports = [ 
        ./../../../modules/common 
        ./hardware-configurations.nix 
    ];

    networking.hostName = "tygos-desktop";
}
