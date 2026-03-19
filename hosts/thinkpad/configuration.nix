{
  lib,
  ...
}:
with lib;
{
  imports = [
    ./hardware-configuration.nix
  ];

  self.defaults.enable = true;
  self.docker.enable = true;
  self.gaming.enable = true;
  self.nas.enable = true;
  self.qmk.enable = true;
  self.ssh.enable = true;
  self.gui.enable = true;

  # services.fprintd = {
  #   enable = true;
  #   package = pkgs.fprintd-tod;
  #   tod.enable = true;
  #   tod.driver = pkgs.libfprint-2-tod1-goodix;
  # };

  #! This value determines the NixOS release from which the default
  #! settings for stateful data, like file locations and database versions
  #! on your system were taken. It‘s perfectly fine and recommended to leave
  #! this value at the release version of the first install of this system.
  #! Before changing this value read the documentation for this option
  #! (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  boot.loader.grub.devices = [ "nodev" ];

  # Temp:

  hardware.bluetooth.enable = true;
  security.sudo.wheelNeedsPassword = false;
}
