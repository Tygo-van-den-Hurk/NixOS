## Defines the configuration options for my Lenovo Thinkpad laptop.

{ config, pkgs, lib, ... } : {

    imports = [ 
        ./../../modules/common/all.nix 
        ./hardware-configurations.nix 
    ];

    networking.hostName = "tygos-desktop";
}
