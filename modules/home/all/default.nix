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
        espanso.enable = mkDefault true;
        gui.enable = mkDefault true;
        styling.enable = mkDefault true;
        wm.enable = mkDefault true;
        xremap.enable = mkDefault true;
      };

      imports = with inputs.self.homeModules; [
        cli
        espanso
        gui
        styling
        unfree
        wm
        xremap
      ];
    };
}
