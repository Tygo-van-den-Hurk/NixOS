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

  config = mkIf cfg.enable {
    programs.gnupg = {
      dirmngr.enable = mkDefault true;
      agent = {
        enable = mkDefault true;
        pinentryPackage = pkgs.pinentry-curses;
        settings =
          let
            one-week = 604800;
          in
          {
            default-cache-ttl = one-week;
            max-cache-ttl = one-week;
          };
      };
    };
  };
}
