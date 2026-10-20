{
  inputs,
  system,
  lib,
}:

let
  inherit (lib) removeAttrs;
  inherit (lib) mapAttrs;
in

mapAttrs (
  _: input:
  (removeAttrs input [
    "apps"
    "checks"
    "devShells"
    "formatter"
    "legacyPackages"
    "packages"
    "lib"
  ])
  // {
    apps = input.apps.${system} or { };
    checks = input.checks.${system} or { };
    devShells = input.devShells.${system} or { };
    formatter = input.formatter.${system} or null;
    legacyPackages = input.legacyPackages.${system} or { };
    packages = input.packages.${system} or { };
    lib = input.lib or { };
  }
) inputs
