## Defines the services that run on the system.
arguments @ {
  config,
  pkgs,
  lib,
  machine-settings,
  ...
}: {
  services.logind = let
    options = {
      ignore = "ignore";
      poweroff = "poweroff";
      reboot = "reboot";
      halt = "halt";
      kexec = "kexec";
      suspend = "suspend";
      hibernate = "hibernate";
      hybrid-sleep = "hybrid-sleep";
      suspend-then-hibernate = "suspend-then-hibernate";
      lock = "lock";
    };
  in {
    lidSwitchDocked = lib.mkDefault options.ignore; # laptop lid is closed and another screen is added.
    lidSwitchExternalPower = lib.mkDefault options.ignore; # laptop lid is closed and the system is on external power.
    lidSwitch = lib.mkDefault options.suspend; # laptop lid is closed
  };
}
