{
  inputs,
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
  imports = [
    inputs.github-actions-nix.flakeModules.default
    ./home-manager.nix
    ./nixos.nix
  ];

  options.${namespace}.${module} = with types; {
    enable = mkOption {
      description = "Whether or not to enable the CI";
      default = true;
      type = bool;
    };
  };

  config = mkIf cfg.enable {
    perSystem =
      { config, pkgs, ... }:
      {
        githubActions.enable = true;

        packages.workflows = config.githubActions.workflowsDir;

        apps.update-ci = with pkgs; rec {
          inherit (program) meta;
          type = "app";
          program = writeShellApplication rec {
            name = "update-ci";
            runtimeInputs = [ git ];
            text = builtins.readFile ./update-ci.sh;
            meta = {
              description = "Updates all the '.nix.yml' GitHub Action workflows.";
              maintainers = with maintainers; [ Tygo-van-den-Hurk ];
              mainProgram = name;
            };
          };
        };
      };
  };
}
