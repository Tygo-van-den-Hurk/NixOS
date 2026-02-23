{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  namespace = "self";
  type = "gui";
  category = "file-viewers";
  program = "thunar";
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
