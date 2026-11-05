{
  inputs,
  ...
}:
let
  secrets = inputs.tygo-van-den-hurk-secrets;
  inherit (inputs.self.lib) find-files;
  namespace = "self";
  module = "secrets";
in
{
  flake.nixosModules.${module} =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    with lib;
    let
      cfg = config.${namespace}.${module};
    in
    {
      imports = find-files {
        exclude = ./default.nix;
        base = ./.;
        extension = ".nix";
        extra = with inputs; [
          sops-nix.nixosModules.default
        ];
      };

      options.${namespace}.${module} = with types; {
        enable = mkOption {
          description = "Whether to use this as a secret backend.";
          default = false;
          type = bool;
        };
      };

      config.environment = mkIf cfg.enable {
        systemPackages = with pkgs; [
          sops
        ];
      };

      config.sops = mkIf cfg.enable {
        defaultSopsFile = mkDefault "${secrets}/secrets.yaml";
        defaultSopsFormat = mkDefault "yaml";
        age.keyFile = mkDefault "/root/.config/sops/private.age.key";
      };
    };
}
