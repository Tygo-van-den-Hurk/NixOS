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
  category = "miscellaneous";
  program = "bitwarden";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  options.${namespace}.${type}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.${category}.enable;
      type = bool;
    };

    autostart.enable = mkOption {
      description = "Whether to make ${program} the default program to open its file type.";
      default = cfg.enable;
      type = bool;
    };

    autostart.config = mkOption {
      description = "The settings to the autostart desktop entry for ${program}.";
      type = attrs;
      default = rec {
        name = program;
        type = "Application";
        desktopName = name;
        exec = getExe cfg.package;
        comment = "startup script for ${program}";
        terminal = false;
        startupNotify = false;
      };
    };

    package = mkOption {
      description = "The package to use for ${program}.";
      default = pkgs.bitwarden-desktop;
      type = package;
    };
  };

  config.home = mkIf cfg.enable {
    packages = [ cfg.package ];
    sessionVariables = mkIf cfg.autostart.enable rec {
      BITWARDEN_SSH_AUTH_SOCK = mkDefault "${config.home.homeDirectory}/.ssh/bitwarden.sock";
      SSH_AUTH_SOCK = BITWARDEN_SSH_AUTH_SOCK;
    };
  };

  config.xdg.autostart = mkIf cfg.autostart.enable {
    entries = singleton (
      pkgs.makeDesktopItem cfg.autostart.config
      + "/share/applications/${cfg.autostart.config.name}.desktop"
    );
  };
}
