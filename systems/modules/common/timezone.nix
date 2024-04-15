## Defines the settings for the timezone.

{ config, pkgs, lib, ... } : {

    time.timeZone = lib.mkDefault "Europe/Amsterdam";
}
