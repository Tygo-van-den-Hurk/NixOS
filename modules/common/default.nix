## impors all the modules in this directory.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    arguments_ = builtins.trace ("Loading: /modules/common...") (arguments); 

in { imports = [ 
        ( import  ./boot         arguments_ )
        ( import  ./environment  arguments_ )
        ( import  ./fonts        arguments_ )
        ( import  ./hardware     arguments_ )
        ( import  ./i18n         arguments_ )
        ( import  ./networking   arguments_ )
        ( import  ./nix          arguments_ )
        ( import  ./nixpkgs      arguments_ )
        ( import  ./security     arguments_ )
        ( import  ./services     arguments_ )
        ( import  ./sound        arguments_ )
        ( import  ./system       arguments_ )
        ( import  ./time         arguments_ )
        ( import  ./users        arguments_ )
    ];
}
 