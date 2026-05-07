_:
let
  namespace = "self";
  module = "espanso";
in
{
  flake.homeModules.${module} =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    with lib;
    let
      cfg = config.${namespace}.${module};
    in
    {
      options.${namespace}.${module} = with types; {
        enable = mkOption {
          description = "Whether to turn on the word remapper.";
          default = false;
          type = bool;
        };

        packages = mkOption {
          description = "The espanso packages to install";
          default = { };
          type = attrsOf (
            submodule (
              { name, ... }:
              {
                options = {

                  enable = mkOption {
                    description = "Whether to install this package.";
                    default = true;
                    example = false;
                    type = bool;
                  };

                  name = mkOption {
                    description = "The name of this package.";
                    default = name;
                    example = "dummy-package";
                    type = str;
                  };

                  version = mkOption {
                    description = "The version of this package.";
                    type = strMatching "^[a-z0-9]+-[A-Za-z0-9+/=]+$";
                    example = "0.0.0";
                  };

                  hash = mkOption {
                    description = "The hash of this package.";
                    type = strMatching "^sha256-[A-Za-z0-9+/=]+$";
                    example = fakeHash;
                    default = fakeHash;
                  };
                };
              }
            )
          );
        };
      };

      config.home = mkIf cfg.enable {
        packages = with pkgs; [ kdotool ];
      };

      config.services.${module} = mkIf cfg.enable {
        enable = mkDefault true;
        matches.base.imports = [ ./matches.yaml ];

        configs.default = {
          undo_backspace = true;
          backspace_limit = 25;
        };

        configs.linux-disabled = {
          filter_os = "linux";
          filter_class = "kitty|code|VSCodium|Alacritty";
          enable = false;
        };
      };

      # config.xdg = mkIf cfg.enable {
      #   configFile = mapAttrs (
      #     name: value: {
      #
      #     }
      #   ) cfg.packages;
      # };

      config.${namespace}.${module} = mkIf cfg.enable {
        packages."no".version = "0.1.0";
      };
    };
}
