## This configuration is the `default` that loads untill I get the flake working.

{ config, pkgs, lib, ... } : { imports = [
        ./system/laptops/thinkpad/configuration.nix
    ];
}
