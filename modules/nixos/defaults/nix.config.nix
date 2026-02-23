{
  inputs,
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "defaults";
  submodule = "nix";
  cfg = config.${namespace}.${module}.${submodule};
in
{
  options.${namespace}.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to fill in a bunch of defaults regarding nix and nixpkgs.";
      default = config.${namespace}.${module}.enable;
      readOnly = true;
      type = bool;
    };
  };

  config = mkIf cfg.enable {
    nix.nixPath = [
      "nixpkgs=${inputs.nixpkgs}"
      "nixos-config=${inputs.self}"
    ];

    nix.settings.trusted-users = [
      "@wheel"
    ];

    nix = {
      checkConfig = mkDefault true;
      checkAllErrors = mkDefault true;
      channel.enable = mkDefault false;
      settings.experimental-features = [
        "nix-command" # Used to enable the use of the `nix` program.
        "flakes" # Used to add flake support like for example this one.
      ];
    };

    nixpkgs = {
      config.allowUnfree = mkDefault true;
      config.allowBroken = mkDefault true;
      flake.setFlakeRegistry = mkDefault true;
      flake.setNixPath = mkDefault true;
    };
  };
}
