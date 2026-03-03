_:
let
  namespace = "self";
  module = "gui";
in
{
  flake.nixosModules.${module} =
    {
      inputs,
      config,
      lib,
      ...
    }:
    with lib;
    let
      cfg = config.${namespace}.${module};
    in
    {
      imports = inputs.self.lib.import-recursively {
        exclude = ./default.nix;
        base = ./.;
      };

      options.${namespace}.${module} = with types; {
        enable = mkOption {
          description = "Whether create a graphical user interface for the system.";
          default = false;
          type = bool;
        };
      };

      config = mkIf cfg.enable {
        programs.hyprland.enable = mkDefault true;
        security.pam.services.hyprlock.enable = mkDefault true;
      };
    };
}
