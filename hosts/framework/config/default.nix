{
  inputs,
  lib,
  ...
}:
with lib;
{
  imports = with inputs; [
    disko.nixosModules.default
    ./hardware.nix
    ./disko.nix
  ];

  self.gui.enable = true;
  self.nas.enable = true;
  self.gui.login.scale = 1.25;
  self.secrets.enable = true;
  self.defaults.enable = true;
  self.gaming.enable = true;

  # xremap host config.
  boot.kernelModules = [ "uinput" ];
  hardware.uinput.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  self.defaults.boot.enable = mkForce false;

  system.stateVersion = "26.05";
}
