{ inputs, ... }:
let
  namespace = "self";
  module = "all";
in
{
  flake.homeModules.${module} =
    {
      config,
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
          description = "Whether to enable all modules under the self namespace.";
          default = false;
          type = bool;
        };
      };

      config.${namespace} = mkIf cfg.enable {
        cli.enable = mkDefault true;
        gui.enable = mkDefault true;
        styling.enable = mkDefault true;
        wm.enable = mkDefault true;
      };

      imports = with inputs.self.homeModules; [
        cli
        gui
        styling
        wm
      ];
    };
}
