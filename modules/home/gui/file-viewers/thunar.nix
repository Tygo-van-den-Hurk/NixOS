{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  type = "gui";
  category = "file-viewers";
  program = "thunar";
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
      default = cfg.enable;
      type = bool;
    };
  };

  config.home = mkIf cfg.enable {
    packages = [ pkgs.xfce.thunar ];
  };

  config.xdg.mimeApps = mkIf cfg.mkDefault rec {
    associations.added = defaultApplications;
    defaultApplications = {
      "inode/directory" = [ "thunar.desktop" ];
    };
  };
}
