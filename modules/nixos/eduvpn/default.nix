_:
let
  namespace = "self";
  module = "eduvpn";
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
          description = "Whether to add eduvpn capabilities to the system.";
          default = false;
          type = bool;
        };
      };

      config.networking.networkmanager = mkIf cfg.enable {
        plugins = with pkgs; [
          networkmanager-openvpn
        ];
      };

      config.environment = mkIf cfg.enable {
        systemPackages = with pkgs; [
          eduvpn-client
        ];
      };

      config.assertions = [
        {
          assertion = cfg.enable -> (config.networking.networkmanager.enable or false);
          message =
            "When you enable the '${namespace}.${module}.enable' option, "
            + "then you must enable network manager.";
        }
      ];
    };
}
