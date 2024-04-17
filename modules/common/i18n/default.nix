## Defines internationalisation settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : { i18n = {
        defaultLocale = lib.mkDefault "en_US.UTF-8";
    };

    imports = [ 
        ( import ./extraLocaleSettings arguments )
    ];
}
