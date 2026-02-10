{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkDefault;
  inherit (lib) mkOption;
  inherit (lib) mkIf;
  inherit (lib) types;

  inherit (types) bool;

  module = "defaults";
  submodule = "locale";

  Dutch = mkDefault "nl_NL.UTF-8";
  British = mkDefault "en_GB.UTF-8";
in
{
  options.${module}.${submodule}.enable = mkOption {
    description = "Whether to use the default locale I use.";
    default = config.${module}.enable;
    readOnly = true;
    type = bool;
  };

  config.i18n = mkIf config.${module}.${submodule}.enable {
    defaultLocale = British;
    extraLocaleSettings = {
      LC_ADDRESS = Dutch;
      LC_IDENTIFICATION = Dutch;
      LC_MEASUREMENT = Dutch;
      LC_MONETARY = Dutch;
      LC_NAME = Dutch;
      LC_NUMERIC = Dutch;
      LC_PAPER = Dutch;
      LC_TELEPHONE = Dutch;
      LC_TIME = British;
    };
  };

  config.time = mkIf config.${module}.${submodule}.enable {
    timeZone = mkDefault "Europe/Amsterdam";
  };
}
