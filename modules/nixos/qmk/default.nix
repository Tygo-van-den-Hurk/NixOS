_:
let
  namespace = "self";
  module = "qmk";
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
          description = "Whether to make the system capable of flashing QMK firmware.";
          default = false;
          type = bool;
        };
      };

      config = mkIf cfg.enable {
        hardware.keyboard.qmk.enable = mkDefault true;
        services.udev.packages = with pkgs; [ via ];
        environment.systemPackages = with pkgs; [ via ];
      };
    };
}
