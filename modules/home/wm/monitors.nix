{
  lib,
  config,
  ...
}:
with lib;
let
  type = "wm";
  category = "monitors";
  cfg = config.${type}.${category};
in
{
  options.${type} = with types; {
    ${category} = mkOption {
      description = "Set of monitors this system has.";
      default = { };
      example = literalExample {
        "eDP-1" = {
          primary = true;
          refresh-rate = 60;
          resolution.vertical = 1080;
          resolution.horizontal = 1920;
          placement = {
            where = "below";
            what = "HDMI-1-1";
          };
        };
      };

      type = attrsOf (
        submodule (
          { name, ... }:
          {
            options = {

              enable = mkOption {
                description = "Whether to enable this monitor.";
                default = true;
                example = false;
                type = bool;
              };

              adapter = mkOption {
                description = "The adapter of this monitor.";
                default = name;
                example = "eDP-1";
                type = str;
              };

              primary = mkOption {
                description = "Whether this is the primary monitor.";
                default = false;
                example = true;
                type = bool;
              };

              refresh-rate = mkOption {
                description = "Refresh rate of the display in Hz.";
                example = 60;
                type = int;
              };

              resolution = {
                horizontal = mkOption {
                  description = "Horizontal resolution of the display in pixels.";
                  example = 1920;
                  type = int;
                };

                vertical = mkOption {
                  description = "Vertical resolution of the display in pixels.";
                  example = 1080;
                  type = int;
                };
              };

              position = {
                horizontal = mkOption {
                  description = "Horizontal resolution of where to render the display in pixels.";
                  example = 1920;
                  default = null;
                  type = nullOr int;
                };

                vertical = mkOption {
                  description = "Vertical resolution of where to render the display in pixels.";
                  example = 1080;
                  default = null;
                  type = nullOr int;
                };
              };

              v-sync = mkOption {
                description = "Whether this monitor supports v-sync.";
                default = false;
                example = true;
                type = bool;
              };

              scale = mkOption {
                description = "The scale of the display in the system.";
                example = 2;
                default = 1;
                type = int;
              };
            };
          }
        )
      );
    };
  };

  config.xdg.configFile."${type}/${category}.json".text = builtins.toJSON cfg;
}
