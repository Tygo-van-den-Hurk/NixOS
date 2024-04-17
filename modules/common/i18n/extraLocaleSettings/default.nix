## Defines all the settings for boot.

{ config, pkgs, lib, machine-settings, ... } : { i18n.extraLocaleSettings = {
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
}