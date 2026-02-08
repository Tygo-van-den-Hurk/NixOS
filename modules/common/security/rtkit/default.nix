## Defines display manager / window manager settings.
#? unknown setting, but was here when I booted.
{
  lib,
  ...
}:
{
  security.rtkit = {
    enable = lib.mkDefault true;
  };
}
