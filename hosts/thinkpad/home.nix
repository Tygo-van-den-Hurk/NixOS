{
  lib,
  ...
}:
with lib;
{
  cli.enable = true;
  gui.enable = false;
  styling.enable = true;
  home.stateVersion = "25.11";
}
