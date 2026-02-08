## Defines internationalisation settings.
{
  lib,
  ...
}:
{
  imports = [
    ./extraLocaleSettings
  ];

  i18n =
    let
      english = lib.mkDefault "en_US.UTF-8";
    in
    {
      defaultLocale = english;
    };
}
