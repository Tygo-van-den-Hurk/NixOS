{
  lib,
  config,
  ...
}:
with lib;
let
  type = "gui";
  category = "file-viewers";
  program = "zathura";
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

  config.programs.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    extraConfig = mkDefault "";
    options = mkDefault { };
    mappings = mkDefault { };
  };

  config.programs.bash = mkIf cfg.enable {
    initExtra = ''
      function zathura() {
        command zathura "$@" &
      }
    '';
  };

  config.programs.zsh = mkIf cfg.enable {
    initExtra = ''
      zathura() {
        command zathura "$@" &
      }
    '';
  };

  config.programs.fish = mkIf cfg.enable {
    interactiveShellInit = ''
      function zathura
        command zathura $argv &
      end
    '';
  };

  config.xdg.mimeApps = mkIf cfg.mkDefault rec {
    associations.added = defaultApplications;
    defaultApplications = {
      "application/pdf" = [ "zathura.desktop" ];
    };
  };
}
