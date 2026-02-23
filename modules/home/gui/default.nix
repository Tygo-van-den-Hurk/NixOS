{ inputs, ... }:
let
  namespace = "self";
  module = "gui";
in
{
  flake.homeModules.${module} =
    {
      lib,
      config,
      ...
    }:
    with lib;
    let
      cfg = config.${namespace}.${module};
    in
    {
      options.${namespace}.${module} = with types; {
        enable = mkOption {
          description = "Whether to enable GUI applications and tools.";
          default = false;
          type = bool;
        };
      };

      config = mkIf cfg.enable {
        # Bug fixes: https://github.com/alacritty/alacritty/issues/5101;
        home.sessionVariables.WINIT_X11_SCALE_FACTOR = mkDefault 1;
        xdg.mimeApps.enable = mkDefault true;
      };

      imports = inputs.self.lib.import-recursively {
        base = ./.;
        exclude = ./default.nix;
      };
    };
}
