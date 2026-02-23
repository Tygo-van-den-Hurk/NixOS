_:
let
  namespace = "self";
  module = "gaming";
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
          description = "Whether to set the system up for gaming.";
          default = false;
          type = bool;
        };
      };

      config = mkIf cfg.enable {
        programs.gamemode.enable = mkDefault true;
        programs.steam = {
          enable = mkDefault true;
          remotePlay.openFirewall = mkDefault true;
          protontricks.enable = mkDefault true;
          dedicatedServer.openFirewall = mkDefault true;
          extraCompatPackages = with pkgs; [ proton-ge-bin ];
          extraPackages = with pkgs; [
            lutris-free
            gamescope
          ];
        };
      };
    };
}
