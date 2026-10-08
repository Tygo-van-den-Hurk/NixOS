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

  imports = with inputs; [
    sops-nix.nixosModules.sops
    "${tygo-van-den-hurk-secrets}"
  ];

  config.environment = mkIf cfg.enable {
    systemPackages = [ pkgs.sops ];
  };

  config.sops.secrets =
    assert config.sops.defaultSopsFormat == "yaml";
    let
      inherit (config.networking) hostName;
      secretsFile =
        pkgs.runCommand "yaml-to.json"
          {
            nativeBuildInputs = with pkgs; [ yj ];
            src = config.sops.defaultSopsFile;
          }
          /* Shell */ ''
            cat "$src" | yj > "$out"
          '';

      inherit (builtins) readFile;
      secretsRead = readFile secretsFile;

      inherit (builtins) fromJSON;
      secretsRaw = fromJSON secretsRead;
      hostSecrets = secretsRaw.hosts.${hostName} or { };
      userSecrets = hostSecrets.users or { };
    in
    mkIf cfg.enable (

      # The passwords for each user
      (pipe userSecrets [
        (filterAttrs (_: value: value ? password))
        (mapAttrs' (
          user: _: {
            name = "hosts/${hostName}/users/${user}/password";
            value = {
              owner = config.users.users.nobody.name;
              inherit (config.users.users.nobody) group;
              neededForUsers = true;
            };
          }
        ))
      ])

      # The other secrets
      // {
        "hosts/${hostName}/password" = mkIf (hostSecrets ? password) {
          owner = config.users.users.nobody.name;
          inherit (config.users.users.nobody) group;
          neededForUsers = true;
        };

        "password" = mkIf (secretsRaw ? password) {
          owner = config.users.users.nobody.name;
          inherit (config.users.users.nobody) group;
          neededForUsers = true;
        };

        "nas/credentials" = {
          owner = config.users.users.nobody.name;
          inherit (config.users.users.nobody) group;
        };
      }
    );
}
