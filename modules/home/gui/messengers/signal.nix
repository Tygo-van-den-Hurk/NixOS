{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  type = "gui";
  category = "messengers";
  program = "signal";
  cfg = config.${type}.${category}.${program};
in
{
  options.${type}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${type}.${category}.enable;
      type = bool;
    };

    mkDefault = mkOption {
      description = "Whether to make ${program} the default program to open its file type.";
      default = config.${type}.${category}.${program}.enable;
      type = bool;
    };
  };

  config.home = mkIf cfg.enable {
    packages = with pkgs; [
      signal-desktop
    ];
  };

  config.xdg.mimeApps = mkIf cfg.mkDefault rec {
    associations.added = defaultApplications;
    defaultApplications = {
      "x-scheme-handler/signalcaptcha" = [ "signal.desktop" ];
      "x-scheme-handler/sgnl" = [ "signal.desktop" ];
    };
  };
}
