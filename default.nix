## This configuration is the `default` that loads untill I get the flake working.

{ config, pkgs, lib, ... } : { imports = [
        ./systems/laptops/thinkpad/configuration.nix
    ];
}
