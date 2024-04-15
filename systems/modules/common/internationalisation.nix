## Defines internationalisation settings.

{ config, pkgs, lib, ... } : { i18n = {

        defaultLocale = lib.mkDefault "en_US.UTF-8";
        
        extraLocaleSettings = {
            LC_ADDRESS = lib.mkDefault "nl_NL.UTF-8";
            LC_IDENTIFICATION = lib.mkDefault "nl_NL.UTF-8";
            LC_MEASUREMENT = lib.mkDefault "nl_NL.UTF-8";
            LC_MONETARY = lib.mkDefault "nl_NL.UTF-8";
            LC_NAME = lib.mkDefault "nl_NL.UTF-8";
            LC_NUMERIC = lib.mkDefault "nl_NL.UTF-8";
            LC_PAPER = lib.mkDefault "nl_NL.UTF-8";
            LC_TELEPHONE = lib.mkDefault "nl_NL.UTF-8";
            LC_TIME = lib.mkDefault "nl_NL.UTF-8";
        };
    };
}
