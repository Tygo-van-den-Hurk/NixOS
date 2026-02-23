{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "wm";
  category = "workspaces";
  cfg = config.${namespace}.${type}.${category};
in
{
  options.${namespace}.${type} = with types; {
    ${category} = mkOption {
      description = "The workspaces a window-manager should have";

      default = rec {
        Terminal.order = 1;
        Code.order = Terminal.order + 1;
        Browser.order = Code.order + 1;
        Messenger.order = Browser.order + 1;
        Files.order = Messenger.order + 1;
        Docker.order = Files.order + 1;
        Scratch.order = Docker.order + 1;
        Void.order = Scratch.order + 1;
      };

      type = attrsOf (
        submodule (
          { name, ... }:
          {
            options = {

              enable = mkOption {
                description = "Adapter name to place this monitor relative to.";
                default = true;
                example = false;
                type = bool;
              };

              name = mkOption {
                description = "The name this workspace will have when displayed some where.";
                example = "Terminal";
                default = name;
                type = str;
              };

              order = mkOption {
                description = "The order in which they should appear in respect to each other.";
                example = 1;
                type = int;
              };

              display = mkOption {
                description = "The name of the adapter this workspace will be displayed onto.";
                example = "eDP-1";
                default = null;
                type = nullOr str;
              };
            };
          }
        )
      );
    };
  };

  config.xdg.configFile."${type}/${category}.json".text = builtins.toJSON cfg;
}
