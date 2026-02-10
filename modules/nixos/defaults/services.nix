{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkOption;
  inherit (lib) mkIf;
  inherit (lib) mkDefault;
  inherit (lib) types;

  inherit (types) bool;

  module = "defaults";
  submodule = "services";
in
{
  options.${module}.${submodule} = {
    enable = mkOption {
      description = "Whether to load the default services.";
      default = config.${module}.enable;
      type = bool;
    };
  };

  config = mkIf config.${module}.${submodule}.enable {
    services.espanso.enable = mkDefault true;
    services.tailscale.enable = mkDefault true;
    services.printing.enable = mkDefault true;
    networking.firewall.checkReversePath = mkDefault "loose"; # Fix for TailScale
  };
}
