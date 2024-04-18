## Defines internationalisation settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    arguments_ = builtins.trace ("Loading: /modules/common/i18n...") (arguments); 

in { i18n = {
        defaultLocale = lib.mkDefault "en_US.UTF-8";
    };

    imports = [ 
        ( import ./extraLocaleSettings arguments_ )
    ];
}
