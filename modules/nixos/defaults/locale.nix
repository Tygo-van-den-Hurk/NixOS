{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "defaults";
  submodule = "locale";
  cfg = config.${namespace}.${module}.${submodule};
in
{
  options.${namespace}.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to use the default locale I use.";
      default = config.${namespace}.${module}.enable;
      readOnly = true;
      type = bool;
    };
  };

  config = mkIf cfg.enable {
    time.timeZone = mkDefault "Europe/Amsterdam";
    i18n =
      let
        Dutch = mkDefault "nl_NL.UTF-8";
        British = mkDefault "en_GB.UTF-8";
      in
      {
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
  };
}
