## Defines internationalisation settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 

    imports = [ ./extraLocaleSettings ];

    i18n = {
        defaultLocale = (lib.mkDefault "en_US.UTF-8");
    };

})
