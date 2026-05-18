{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "defaults";
  submodule = "programs";
  cfg = config.${namespace}.${module}.${submodule};
in
{
  options.${namespace}.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to fill in a bunch of defaults programs.";
      default = config.${namespace}.${module}.enable;
      readOnly = true;
      type = bool;
    };
  };

  config.programs.gnupg = mkIf cfg.enable {
    dirmngr.enable = mkDefault true;
    agent = {
      enable = mkDefault true;
      pinentryPackage = pkgs.pinentry-curses;
      settings =
        let
          one-second = 1;
          one-minute = 60 * one-second;
          one-hour = 60 * one-minute;
          one-day = 24 * one-hour;
          one-week = 7 * one-day;
        in
        {
          default-cache-ttl = one-week;
          max-cache-ttl = one-week;
        };
    };
  };
}
