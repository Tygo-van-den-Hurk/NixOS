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
  options.${namespace}.${module} = with types; {
    packages = mkOption {
      description = "The package to generate CI/CD for.";
      type = attrsOf (
        submodule (
          { name, ... }:
          {
            options.enable = mkOption {
              description = "Whether or not to generate CI for this package.";
              default = true;
              type = bool;
            };

            options.systems = mkOption {
              description = "The architectures to build this package for.";
              type = listOf (enum [
                "x86_64-linux"
                "aarch64-linux"
              ]);
            };

            options.name = mkOption {
              description = "The name of this package.";
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

        packageToString = _key: value: {
          name = "Building package \"${value.name}\"";

          on = rec {
            # pull_request = push; # option not defined yet...
            push = {
              branches = [ "main" ];
              paths = [
                "packages/${value.name}/**"
                "flake.lock"
              ];
            };
          };

          jobs = builtins.listToAttrs (
            map (system: {
              name = "build-${system}";
              value = {
                name = "Building '${value.name}' on '${system}'.";
                runsOn = if system == "x86_64-linux" then "ubuntu-latest" else "ubuntu-arm-latest";

                timeoutMinutes = 10;

                steps = [
                  steps.checkout-repository
                  steps.install-nix

                  (steps.nix-build {
                    name = "Building '${value.name}' on '${system}'.";
                    attr = "checks.${system}.${value.name}";
                  })
                ];
              };
            }) value.systems
          );
        };

        enabled = filterAttrs (_: value: value.enable) cfg.packages;
        workflows = mapAttrs packageToString enabled;
      in
      {
        githubActions = {
          inherit workflows;
        };
      };
  };
}
