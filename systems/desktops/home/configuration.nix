## Defines the configuration options for my desktop at home.

{ config, pkgs, lib, ... } : let
    machine-settings = import ../common-settings.nix // import ./settings.nix;
in { imports = [ 
        ./../../../modules/common 
        ./hardware-configuration.nix
    ];
}
