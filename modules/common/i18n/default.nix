## Defines internationalisation settings.

{ config, pkgs, lib, ... } : { i18n = {
        defaultLocale = lib.mkDefault "en_US.UTF-8";
    };

    imports = [ 
        ./extraLocaleSettings 
    ];
}
