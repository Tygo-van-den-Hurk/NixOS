## Defines the configuration options for my Lenovo Thinkpad laptop.

arguments @ { config, pkgs, lib, ... } : let
    machine-settings = ( import ../common-settings.nix // import ./settings.nix );
in { imports = [ 
        ( import ./../../../modules/common ( arguments // { machine-settings = machine-settings; } ) )
        ./hardware-configuration.nix 
    ];
}
