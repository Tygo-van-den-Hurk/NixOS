{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "gui";
  category = "file-viewers";
  program = "gimp";
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
    packages = [
      pkgs.${program}
    ];
  };

  config.xdg.mimeApps = mkIf cfg.mkDefault rec {
    associations.added = {
      "image/png" = [ "gimp.desktop" ];
      "image/jpeg" = [ "gimp.desktop" ];
      "image/gif" = [ "gimp.desktop" ];
      "image/webp" = [ "gimp.desktop" ];
      "image/bmp" = [ "gimp.desktop" ];
      "image/tiff" = [ "gimp.desktop" ];
      "image/x-xcf" = [ "gimp.desktop" ];
      "image/svg+xml" = [ "gimp.desktop" ];
    };
  };
}
