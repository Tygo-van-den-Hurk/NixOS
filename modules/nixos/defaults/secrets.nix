{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  namespace = "self";
  module = "defaults";
  submodule = "secrets";
  cfg = config.${namespace}.${module}.${submodule};
in
{
  options.${namespace}.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to load the defaults secrets.";
      default = config.${namespace}.${module}.enable;
      type = bool;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.sops ];

    sops = {
      defaultSopsFile = mkDefault "${inputs.tygo-van-den-hurk-secret}/secrets.yaml";
      defaultSopsFormat = mkDefault "yaml";
    };

    sops.secrets."hosts/${config.networking.hostName}/password" = {
      owner = config.users.users.nobody.name;
      inherit (config.users.users.nobody) group;
      neededForUsers = true;
    };

    sops.secrets."nas/credentials" = {
      owner = config.users.users.nobody.name;
      inherit (config.users.users.nobody) group;
    };
  };

  imports = [
    inputs.sops-nix.nixosModules.sops
    "${inputs.tygo-van-den-hurk-secrets}"
  ];
}
