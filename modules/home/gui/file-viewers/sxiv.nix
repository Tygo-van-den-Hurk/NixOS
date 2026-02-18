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
  program = "sxiv";
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
    packages = [ pkgs.sxiv ];
  };

  config.xdg.mimeApps = mkIf cfg.mkDefault rec {
    associations.added = defaultApplications;
    defaultApplications = {
      "image/jpeg" = [ "sxiv.desktop" ];
      "image/png" = [ "sxiv.desktop" ];
      "image/gif" = [ "sxiv.desktop" ];
      "image/webp" = [ "sxiv.desktop" ];
      "image/bmp" = [ "sxiv.desktop" ];
      "image/svg+xml" = [ "sxiv.desktop" ];
    };
  };
}
