## Defines all the settings for boot.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 

    i18n.extraLocaleSettings = let dutch = "nl_NL.UTF-8"; in {
        LC_ADDRESS        = (lib.mkDefault dutch);
        LC_IDENTIFICATION = (lib.mkDefault dutch);
        LC_MEASUREMENT    = (lib.mkDefault dutch);
        LC_MONETARY       = (lib.mkDefault dutch);
        LC_NAME           = (lib.mkDefault dutch);
        LC_NUMERIC        = (lib.mkDefault dutch);
        LC_PAPER          = (lib.mkDefault dutch);
        LC_TELEPHONE      = (lib.mkDefault dutch);
        LC_TIME           = (lib.mkDefault dutch);
    };

})
