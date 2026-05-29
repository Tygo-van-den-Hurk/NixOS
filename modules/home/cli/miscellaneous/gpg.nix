{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "cli";
  category = "miscellaneous";
  program = "gpg";
  cfg = config.${namespace}.${module}.${category}.${program};
in
{
  options.${namespace}.${module}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${module}.${category}.enable;
      type = bool;
    };
  };

  config.programs.${program} = mkIf cfg.enable rec {
    enable = mkDefault true;
    homedir = mkDefault "${config.xdg.dataHome}/${program}";
    mutableKeys = mkDefault true;
    mutableTrust = mkDefault false;
    publicKeys = with pkgs; [
      {
        source = fetchurl {
          url = "https://keys.openpgp.org/vks/v1/by-fingerprint/1AAE628A2D49059717AEA7F87CA2CBB275058A44";
          sha256 = "sha256-IqrjTyNkDBumZKSurpPJSodwEQWyLyF+5YSsAvkCWHY=";
        };
      }
      {
        source = fetchurl {
          url = "https://github.com/web-flow.gpg";
          sha256 = "sha256-bor2h/YM8/QDFRyPsbJuleb55CTKYMyPN4e9RGaj74Q=";
        };
      }
    ];
  };

  config.services.gpg-agent = mkIf cfg.enable rec {
    enable = mkDefault true;
    verbose = mkDefault true;
    noAllowExternalCache = mkDefault true;
    enableBashIntegration = mkDefault true;
    enableFishIntegration = mkDefault true;
    enableZshIntegration = mkDefault true;
    pinentry.package = mkDefault pkgs.pinentry-curses;
    pinentry.program = mkDefault "pinentry-curses";
    defaultCacheTtl = mkDefault (60 * 60 * 24 * 7);
    maxCacheTtl = mkDefault (60 * 60 * 24 * 7);
  };
}
