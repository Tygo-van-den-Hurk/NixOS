_:
let
  namespace = "self";
  module = "gui";
in
{
  flake.nixosModules.${module} =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    with lib;
    let
      cfg = config.${namespace}.${module};
    in
    {
      options.${namespace}.${module} = with types; {
        enable = mkOption {
          description = "Whether create a graphical user interface for the system.";
          default = false;
          type = bool;
        };
      };

      config = mkIf cfg.enable {
        programs.hyprland.enable = mkDefault true;
        services.displayManager.sddm = {
          enable = mkDefault true;
          wayland.enable = mkDefault true;
          autoNumlock = mkDefault true;
          theme = mkDefault "sddm-astronaut-theme";
          extraPackages= [
            (pkgs.fetchFromGitHub {
              owner = "Keyitdev";
              repo = "sddm-astronaut-theme";
              rev = "d73842c761f7d7859f3bdd80e4360f09180fad41";
              hash = "sha256-+94WVxOWfVhIEiVNWwnNBRmN+d1kbZCIF10Gjorea9M=";
            })
          ];
        };
      };
    };
}
