arguments@{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkOption;
  inherit (lib) mkIf;
  inherit (lib) types;

  inherit (types) bool;

  module = "defaults";
  submodule = "console";
in
{
  options.${module}.${submodule}.enable = mkOption {
    description = "Whether to load defaults for the console.";
    default = config.${module}.enable;
    type = bool;
  };

  config = mkIf config.${module}.${submodule}.enable (
    (import inputs.tygo-van-den-hurk-secrets arguments)
    // {
      environment.systemPackages = [ pkgs.sops ];
    }
  );

  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
}
