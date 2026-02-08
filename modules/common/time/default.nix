## Defines the settings for the timezone.
{
  lib,
  ...
}:
{
  time = {
    timeZone = lib.mkDefault "Europe/Amsterdam";
  };
}
