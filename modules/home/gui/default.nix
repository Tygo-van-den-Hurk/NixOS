{ inputs, ... }:
let
  module = "gui";
in
{
  flake.homeModules.${module} =
    {
      lib,
      ...
    }:
    with lib;
    {
      options.${module} = with types; {
        enable = mkOption {
          description = "Whether to enable GUI applications and tools.";
          default = false;
          type = bool;
        };
      };

      # Bug fixes: https://github.com/alacritty/alacritty/issues/5101;
      config.home.sessionVariables.WINIT_X11_SCALE_FACTOR = 1;
      config.xdg.mimeApps.enable = true;

      imports = inputs.self.lib.import-recursively {
        base = ./.;
        exclude = ./default.nix;
      };
    };
}
