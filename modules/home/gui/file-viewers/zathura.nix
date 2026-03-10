{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "gui";
  category = "file-viewers";
  program = "zathura";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  options.${namespace}.${type}.${category}.${program} = with types; {

    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.${category}.enable;
      type = bool;
    };

    mkDefault = mkOption {
      description = "Whether to make ${program} the default program to open its file type.";
      default = config.${namespace}.${type}.${category}.${program}.enable;
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
        nohup ${getExe config.programs.zathura.package} "$@" &> /dev/null &
      }
    '';
  };

  config.programs.zsh = mkIf cfg.enable {
    initExtra = ''
      zathura() {
        nohup ${getExe config.programs.zathura.package} "$@" &> /dev/null &
      }
    '';
  };

  config.programs.fish = mkIf cfg.enable {
    interactiveShellInit = ''
      function zathura
        nohup ${getExe config.programs.zathura.package} $argv > /dev/null 2>&1 &
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
