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
    nixos = mkOption {
      description = "The NixOS systems to generate CI/CD for.";
      type = attrsOf (
        submodule (
          { name, ... }:
          {
            options.enable = mkOption {
              description = "Whether or not to generate CI for this NixOS system.";
              default = true;
              type = bool;
            };

            options.system = mkOption {
              description = "The architecture of this NixOS system.";
              type = enum [
                "x86_64-linux"
                "aarch64-linux"
              ];
            };

            options.hostname = mkOption {
              description = "The hostname of this NixOS system.";
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
          name = "Validating NixOS configuration for '${value.hostname}'";

          on = rec {
            # pull_request = push; # option not defined yet...
            push = {
              branches = [ "main" ];
              paths = [
                "hosts/${value.hostname}"
                "modules"
                "lib"
                "flake.*"
              ];
            };
          };

          jobs.build = {
            name = "Validating NixOS configuration for '${value.hostname}'";
            runsOn = if value.system == "x86_64-linux" then "ubuntu-latest" else "ubuntu-arm-latest";
            timeoutMinutes = 10;
            steps = [
              steps.checkout-repository
              steps.install-nix
              (steps.nix-build {
                name = "Validating NixOS configuration for '${value.hostname}' using fake secrets";
                attr = "checks.${value.system}.${value.hostname}";
              })
            ];
          };
        };

        enabled = filterAttrs (_: value: value.enable) cfg.configurations.nixos;
        workflows = mapAttrs configurationToString enabled;
      in
      {
        githubActions = {
          inherit workflows;
        };
      };
  };
}
