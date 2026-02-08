## Defines all the settings for the boot loader.
{
  lib,
  ...
}:
{
  imports = [
    ./efi
    ./grub
    ./systemd-boot
  ];

  boot.loader = {
    timeout = lib.mkDefault 5;
  };
}
