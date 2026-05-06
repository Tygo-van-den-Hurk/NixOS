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
  program = "f3d";
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

    settings = mkOption {
      description = "The settings for ${program}.";
      type = listOf attrs;
      default = [ ];
    };
  };

  config.home = mkIf cfg.enable {
    packages = [
      pkgs.${program}
    ];
  };

  config.xdg.mimeApps = mkIf cfg.mkDefault rec {
    associations.added = defaultApplications;
    defaultApplications = {
      "model/stl" = [ "f3d.desktop" ];
      "model/x.stl-ascii" = [ "f3d.desktop" ];
      "application/sla" = [ "f3d.desktop" ];
      "application/vnd.ms-pki.stl" = [ "f3d.desktop" ];
      "model/obj" = [ "f3d.desktop" ];
      "application/x-tgif" = [ "f3d.desktop" ];
      "model/gltf+json" = [ "f3d.desktop" ];
      "model/gltf-binary" = [ "f3d.desktop" ];
      "application/x-ply" = [ "f3d.desktop" ];
      "model/step" = [ "f3d.desktop" ];
      "model/step+xml" = [ "f3d.desktop" ];
      "application/step" = [ "f3d.desktop" ];
      "application/step+xml" = [ "f3d.desktop" ];
      "model/iges" = [ "f3d.desktop" ];
      "application/iges" = [ "f3d.desktop" ];
      "application/octet-stream" = [ "f3d.desktop" ];
      "model/vtk" = [ "f3d.desktop" ];
      "model/3mf" = [ "f3d.desktop" ];
      "model/vnd.collada+xml" = [ "f3d.desktop" ];
      "model/vrml" = [ "f3d.desktop" ];
    };
  };

  config.xdg.configFile."f3d/config.json" = mkIf cfg.enable rec {
    text = builtins.toJSON cfg.settings;
  };

  config.${namespace}.${type}.${category}.${program} =
    mkIf (cfg.enable && config ? stylix && config.stylix.enable)
      rec {
        settings = [
          {
            options.background-color = "#${config.stylix.base16Scheme.base00 or "000000"}";
            options.color = "#${config.stylix.base16Scheme.base05 or "FFFFFF"}";
          }
        ];
      };
}
