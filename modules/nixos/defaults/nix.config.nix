{
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkDefault;
  inherit (lib) mkOption;
  inherit (lib) mkIf;
  inherit (lib) types;

  inherit (types) bool;

  module = "defaults";
  submodule = "nix";

  nixPath = [
    "nixpkgs=${inputs.nixpkgs}"
    "nixos-config=${inputs.self}"
  ];

  trusted-users = [
    "@wheel"
    "@nix"
  ];
in
{
  options.${module}.${submodule}.enable = mkOption {
    description = "Whether to fill in a bunch of defaults regarding nix and nixpkgs.";
    default = config.${module}.enable;
    readOnly = true;
    type = bool;
  };

  config = mkIf config.${module}.${submodule}.enable {
    users.users.${config.${module}."main-user".username}.extraGroups = [ "nix" ];

    nix = {
      inherit nixPath;
      checkConfig = mkDefault true;
      checkAllErrors = mkDefault true;
      channel.enable = mkDefault false;
      settings = {
        inherit trusted-users;
        experimental-features = [
          "nix-command" # Used to enable the use of the `nix` program.
          "flakes" # Used to add flake support like for example this one.
        ];
      };
    };

    nixpkgs = {
      config.allowUnfree = mkDefault true;
      config.allowBroken = mkDefault true;
      flake.setFlakeRegistry = mkDefault true;
      flake.setNixPath = mkDefault true;
    };
  };
}
