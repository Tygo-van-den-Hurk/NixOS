{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "defaults";
  submodule = "boot";
  cfg = config.${module}.${submodule};
in
{
  options.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to this module.";
      default = config.${module}.enable;
      type = bool;
    };
  };

  config.boot = mkIf cfg.enable {
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
