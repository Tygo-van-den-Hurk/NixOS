{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "defaults";
  submodule = "services";
  cfg = config.${namespace}.${module}.${submodule};
in
{
  options.${namespace}.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to load the default services.";
      default = config.${namespace}.${module}.enable;
      type = bool;
    };
  };

  config = mkIf cfg.enable {
    services.espanso.enable = mkDefault true;
    services.tailscale.enable = mkDefault true;
    services.printing.enable = mkDefault true;
    networking.firewall.checkReversePath = mkDefault "loose"; # Fix for TailScale

    services.pipewire = {
      enable = mkDefault true;
      alsa.enable = mkDefault true;
      alsa.support32Bit = mkDefault true;
      pulse.enable = mkDefault true;
    };
  };
}
