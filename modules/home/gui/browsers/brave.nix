{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  type = "gui";
  category = "browsers";
  program = "brave";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  options.${namespace}.${type}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.${category}.enable;
      type = bool;
    };
  };

  config.home = mkIf cfg.enable {
    packages = with pkgs; [
      brave
    ];
  };

  config.xdg.mimeApps = mkIf cfg.enable rec {
    associations.added = {
      "x-scheme-handler/http" = [ "${program}.desktop" ];
      "x-scheme-handler/https" = [ "${program}.desktop" ];
      "x-scheme-handler/chrome" = [ "${program}.desktop" ];
      "application/x-extension-htm" = [ "${program}.desktop" ];
      "application/x-extension-html" = [ "${program}.desktop" ];
      "application/x-extension-shtml" = [ "${program}.desktop" ];
      "application/x-extension-xhtml" = [ "${program}.desktop" ];
      "application/x-extension-xht" = [ "${program}.desktop" ];
      "application/xhtml+xml" = [ "${program}.desktop" ];
      "text/html" = [ "${program}.desktop" ];
    };
  };
}
