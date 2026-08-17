let
  namespace = "self";
  module = "gui";
in
{
  flake.nixosModules.${module} =
    {
      inputs,
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

      config.programs.hyprland = mkIf cfg.enable {
        enable = mkDefault true;
        withUWSM = mkDefault true;
      };

      config.programs.uwsm = mkIf cfg.enable {
        enable = mkDefault true;
        waylandCompositors.hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/start-hyprland";
        };
      };

      config.security.pam.services.hyprlock = {
        enable = mkDefault true;
      };

      config.xdg.portal = mkIf cfg.enable {
        enable = mkDefault true;
        xdgOpenUsePortal = mkDefault true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
        ];
      };

      config.services = mkIf cfg.enable {
        pulseaudio.enable = mkDefault false;
        pipewire = {
          enable = mkDefault true;
          alsa.enable = mkDefault true;
          alsa.support32Bit = mkDefault true;
          pulse.enable = mkDefault true;
        };
      };
    };
}
