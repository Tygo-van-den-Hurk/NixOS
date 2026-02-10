{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkDefault;
  inherit (lib) mkOption;
  inherit (lib) mkIf;
  inherit (lib) types;

  inherit (types) bool;

  module = "defaults";
  submodule = "boot";
in
{
  options.${module}.${submodule}.enable = mkOption {
    description = "Whether to this module.";
    default = config.${module}.enable;
    type = bool;
  };

  config.boot = mkIf config.${module}.${submodule}.enable {
    loader.timeout = mkDefault 5; # seconds

    loader.grub = {
      enable = mkDefault true;
      useOSProber = mkDefault true;
      efiSupport = mkDefault true;
      devices = [ "nodev" ];
      theme = mkDefault (
        pkgs.sleek-grub-theme.override {
          withBanner = config.networking.hostName;
          withStyle = "dark";
        }
      );
    };

    loader.efi = {
      canTouchEfiVariables = mkDefault true;
    };

    plymouth = {
      enable = mkDefault true;
      themePackages = [ pkgs.nixos-bgrt-plymouth ];
      theme = mkDefault "bgrt";
    };
  };
}
