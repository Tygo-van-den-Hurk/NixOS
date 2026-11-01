let
  namespace = "self";
  module = "gaming";
  sessionVariables = {
    "STEAM_EXTRA_COMPAT_TOOLS_PATHS" = "\${HOME}/.steam/root/compatibilitytools.d";
  };
in
{
  flake.nixosModules.${module} =
    {
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
      options.${namespace}.${module} = with types; {
        enable = mkOption {
          description = "Whether to set the system up for gaming.";
          default = false;
          type = bool;
        };
      };

      config.programs.steam = mkIf cfg.enable {
        enable = mkDefault true;
        remotePlay.openFirewall = mkDefault true;
        protontricks.enable = mkDefault true;
        dedicatedServer.openFirewall = mkDefault true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
        gamescopeSession.enable = mkDefault true;
      };

      config.programs.gamemode = mkIf cfg.enable {
        enable = mkDefault true;
      };

      config.environment = mkIf cfg.enable {
        inherit sessionVariables;
        systemPackages = with pkgs; [
          lutris-free
          protonup-ng
          mangohud
        ];
      };
    };
}
