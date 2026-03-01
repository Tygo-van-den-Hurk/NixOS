{
  config,
  lib,
  META,
  ...
}:
with lib;
let
  namespace = "self";
  module = "defaults";
  submodule = "networking";
  cfg = config.${namespace}.${module}.${submodule};
in
{
  options.${namespace}.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to use the default networking settings.";
      default = config.${namespace}.${module}.enable;
      readOnly = true;
      type = bool;
    };
  };

  config = mkIf cfg.enable {
    networking.hostName = mkDefault META.hostName;
    networking.networkmanager.enable = mkDefault true;
    networking.firewall.enable = mkDefault true; # do not change as it is for all machines.
    networking.firewall.allowedTCPPorts = mkDefault [ ]; # do not change as it is for all machines.
    networking.firewall.allowedUDPPorts = mkDefault [ ]; # do not change as it is for all machines.
  };
}
