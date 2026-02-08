## Defines all the settings for boot.
{
  lib,
  ...
}:
{
  i18n.extraLocaleSettings =
    let
      Dutch = lib.mkDefault "nl_NL.UTF-8";
      British = lib.mkDefault "en_GB.UTF-8";
    in
    {
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
}
