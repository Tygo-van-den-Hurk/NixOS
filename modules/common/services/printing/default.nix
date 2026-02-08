## Defines the printing service that runs on the system.
{
  lib,
  ...
}:
{
  services.printing = {
    enable = lib.mkDefault true;
  };
}
