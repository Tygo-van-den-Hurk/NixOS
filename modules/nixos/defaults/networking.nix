{
  config,
  lib,
  hostName,
  ...
}:
with lib;
let
  module = "defaults";
  submodule = "networking";
  cfg = config.${module}.${submodule};
in
{
  options.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to use the default networking settings.";
      default = config.${module}.enable;
      readOnly = true;
      type = bool;
    };
  };

  config = mkIf cfg.enable {
    networking.hostName = mkDefault hostName;
    networking.networkmanager.enable = mkDefault true;
    networking.firewall.enable = mkDefault true; # do not change as it is for all machines.
    networking.firewall.allowedTCPPorts = mkDefault [ ]; # do not change as it is for all machines.
    networking.firewall.allowedUDPPorts = mkDefault [ ]; # do not change as it is for all machines.
  };
}
