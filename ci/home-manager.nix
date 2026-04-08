{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "ci";
  cfg = config.${namespace}.${module};
in
{
  options.${namespace}.${module}.configurations = with types; {
    home-manager = mkOption {
      description = "The Home Manager configuration to generate CI/CD for.";
      type = attrsOf (
        submodule (
          { name, ... }:
          {
            options.enable = mkOption {
              description = "Whether or not to generate CI for this Home Manager configuration.";
              default = true;
              type = bool;
            };

            options.system = mkOption {
              description = "The architecture of the system of this Home Manager configuration.";
              type = enum [
                "x86_64-linux"
                "aarch64-linux"
              ];
            };

            options.username = mkOption {
              description = "The username of this Home Manager configuration.";
              default = name;
              type = str;
            };

            options.hostname = mkOption {
              description = "The hostname of this Home Manager configuration.";
              default = name;
              type = str;
            };
          }
        )
      );
    };
  };

  # this config essentially models a GitHub workflow file.
  config = mkIf cfg.enable {
    perSystem =
      let
        inherit (import ./values.lib.nix) steps;

        configurationToString = _key: value: {
          name = "Validating Home Manager configuration for '${value.hostname}'";

          on = rec {
            # pull_request = push; # option not defined yet...
            push = {
              branches = [ "main" ];
              paths = [
                "homes/${value.username}@${value.hostname}"
                "modules"
                "lib"
                "flake.*"
              ];
            };
          };

          jobs.build = {
            name = "Validating Home Manager configuration for '${value.username}@${value.hostname}'";
            runsOn = if value.system == "x86_64-linux" then "ubuntu-latest" else "ubuntu-arm-latest";
            timeoutMinutes = 10;
            steps = [
              steps.checkout-repository
              steps.install-nix
              (steps.nix-build {
                name = "Validating Home Manager configuration for '${value.username}@${value.hostname}' using fake secrets";
                attr = "checks.${value.system}.\"${value.username}@${value.hostname}\"";
              })
            ];
          };
        };

        enabled = filterAttrs (_: value: value.enable) cfg.configurations.home-manager;
        workflows = mapAttrs configurationToString enabled;
      in
      {
        githubActions = {
          inherit workflows;
        };
      };
  };
}
