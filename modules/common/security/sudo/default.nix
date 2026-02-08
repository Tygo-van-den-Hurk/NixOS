## Defines display manager / window manager settings.
{
  lib,
  ...
}:
{
  security.sudo = {
    wheelNeedsPassword = lib.mkDefault true;
    extraConfig = lib.mkDefault "Defaults pwfeedback";
  };
}
