## impors all the modules in this directory.

arguments @ { config, pkgs, lib, machine-settings, ... } : { imports = [ 
        ( import  ./boot         arguments )
        ( import  ./environment  arguments )
        ( import  ./hardware     arguments )
        ( import  ./i18n         arguments )
        ( import  ./networking   arguments )
        ( import  ./nix          arguments )
        ( import  ./nixpkgs      arguments )
        ( import  ./security     arguments )
        ( import  ./services     arguments )
        ( import  ./sound        arguments )
        ( import  ./system       arguments )
        ( import  ./time         arguments )
        ( import  ./users        arguments )
    ];
}
 