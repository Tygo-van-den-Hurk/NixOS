{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "wm";
  category = "assignments";
  cfg = config.${namespace}.${type}.${category};
in
{
  options.${namespace}.${type} = with types; {
    ${category} = mkOption {
      description = "Assign windows/applications to a workspace.";
      default = { };
      example = literalExample {
        ${namespace}.${type}.${category} = {
          kitty.workspace = "Terminal";
          code.workspace = "Code";
          firefox.workspace = "Browser";
          discord.workspace = "Messenger";
        };
      };

      type =
        let

          options = {
            enable = mkOption {
              description = "Whether or write this rule to a config file.";
              default = true;
              type = bool;
            };

            workspace = mkOption {
              description = "The workspace it belongs to.";
              type = str;
              apply =
                value:
                if config.${namespace}.${type}.workspaces.${value}.enable or false then
                  value
                else
                  throw "the workspace ${value} is not an existing/enabled workspace";
            };
          };
        in
        attrsOf (oneOf [

          # Raw configuration fallback:

          (addCheck (submodule {
            options = {
              inherit (options) enable;

              raw = {
                hyprland = mkOption {
                  description = "the literal rule to put in the config.";
                  type = str;
                };

                i3 = mkOption {
                  description = "the literal rule to put in the config.";
                  type = str;
                };
              };
            };
          }) (module: module ? "raw"))

          # based on: window class

          (submodule (
            { name, ... }:
            {
              options = {
                inherit (options) enable;
                inherit (options) workspace;

                class = mkOption {
                  description = "The class of the window";
                  default = name;
                  type = str;
                };

                case_insensitive = mkOption {
                  description = "Whether or not the class name is case insensitive.";
                  default = true;
                  type = bool;
                };
              };
            }
          ))
        ]);
    };
  };

  config.xdg.configFile."${type}/${category}.json".text = builtins.toJSON cfg;
}
