## Defines the configuration options for this machine.
#! You should not have to change this file, all changes should happen in either the modules, or the settings.
arguments @ { config, pkgs, lib, ... } : let
    
    machine-settings = ( import ../common-settings.nix // import ./settings.nix );
    arguments_ = builtins.trace "Loading: system..." ( arguments // { machine-settings = machine-settings; } ); 

in { imports = [ 
        ( import ./../../../modules  arguments_ )
        ./hardware-configuration.nix 
    ];
}
