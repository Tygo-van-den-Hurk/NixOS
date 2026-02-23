{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "defaults";
  submodule = "auto-upgrade";
  cfg = config.${namespace}.${module}.${submodule};
in
{
  options.${namespace}.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to this module.";
      default = config.${namespace}.${module}.enable;
      type = bool;
    };
  };

  config.system.autoUpgrade = mkIf cfg.enable {
    flake = mkDefault "github:Tygo-van-den-Hurk/NixOS";
    runGarbageCollection = mkDefault false;
    enable = mkDefault true;
    allowReboot = mkDefault true;
    dates = mkDefault "daily";
    fixedRandomDelay = mkDefault true;
    persistent = mkDefault true;
    flags = [ "--show-trace" ];
    operation = mkDefault "switch";
  };
}
