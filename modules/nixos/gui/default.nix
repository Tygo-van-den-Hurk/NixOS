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

      config.programs = mkIf cfg.enable {
        hyprland.enable = mkDefault true;
        # hyprlock.enable = mkDefault true;
        # Hyprlock starts HyprIdle, and since my laptop has problems
        # starting now I'm thinking maybe this is the cause for it?
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
