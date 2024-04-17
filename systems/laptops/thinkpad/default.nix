## Defines the configuration options for this machine.
#! You should not have to change this file, all changes should happen in either the modules, or the settings.
arguments @ { config, pkgs, lib, ... } : let
    machine-settings = ( import ../common-settings.nix // import ./settings.nix );
in { imports = [ 
        ( import ./../../../modules/common ( arguments // { machine-settings = machine-settings; } ) )
        ./hardware-configuration.nix 
    ];
}
