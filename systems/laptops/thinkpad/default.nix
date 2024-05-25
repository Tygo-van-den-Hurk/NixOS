## Defines the configuration options for this machine.
#! You should not have to change this file, all changes should happen in either the modules, or the settings.
arguments @ { config, pkgs, lib, programs, input, ... } : { imports = [ 
        ( import ./../../../modules  arguments )
        ./hardware-configuration.nix 
    ];


    # add custom Nix configurations below:
    #
    #   ...
    #
}
