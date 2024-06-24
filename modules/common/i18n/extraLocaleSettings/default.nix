## Defines all the settings for boot.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    language = builtins.trace ("Loading: ${toString ./.}...") ("nl_NL.UTF-8"); 

in { i18n.extraLocaleSettings = {
        LC_ADDRESS        = lib.mkDefault language;
        LC_IDENTIFICATION = lib.mkDefault language;
        LC_MEASUREMENT    = lib.mkDefault language;
        LC_MONETARY       = lib.mkDefault language;
        LC_NAME           = lib.mkDefault language;
        LC_NUMERIC        = lib.mkDefault language;
        LC_PAPER          = lib.mkDefault language;
        LC_TELEPHONE      = lib.mkDefault language;
        LC_TIME           = lib.mkDefault language;
    };
}