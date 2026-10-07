{
  inputs,
  ...
}:
let
  inherit (inputs.self.lib) find-files;
  namespace = "self";
  module = "gui";
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
          description = "Whether to enable GUI applications and tools.";
          default = false;
          type = bool;
        };
      };

      config.home.sessionVariables = mkIf cfg.enable {
        # Bug fixes: https://github.com/alacritty/alacritty/issues/5101;
        WINIT_X11_SCALE_FACTOR = mkDefault 1;
      };

      imports = find-files {
        base = ./.;
        exclude = ./default.nix;
        extension = ".nix";
      };
    };
}
