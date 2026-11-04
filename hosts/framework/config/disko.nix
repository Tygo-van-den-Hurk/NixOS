# To install, run the disko command on this file:
#
#   sudo nix --experimental-features "nix-command flakes" \
#       run github:nix-community/disko/latest -- \
#       --mode destroy,format,mount /path/to/disko.nix
#
# Then, enroll the TMP module
#
#   COPY FROM WEBSITE
#
# Finally install NixOS:
#
#   sudo nixos-install --root /mnt --flake '.#<hostname>'
#
# Then you're safe to reboot. Now you don't need to enter the
# password every time you want to boot.
let
  swap.size = "40G";
  id = "nvme-eui.0026b76845757da5";
  mountOptions = [
    "compress=zstd"
    "noatime"
  ];
in
{
  fileSystems."/nix".neededForBoot = true;
  fileSystems."/persist".neededForBoot = true;

  boot.initrd = { # you might have to remove this before enrolling?
    systemd.enable = true;
    luks.devices."encrypted".crypttabExtraOpts = [
      "tpm2-device=auto"
    ];
  };

  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/disk/by-id/${id}";
    content.type = "gpt";

    content.partitions.esp = {
      size = "1G";
      type = "EF00";
      content = {
        type = "filesystem";
        format = "vfat";
        mountpoint = "/boot";
        mountOptions = [
          "umask=0077"
        ];
      };
    };

    content.partitions.luks = {
      size = "100%";
      content.type = "luks";
      content.name = "encrypted";
      content = {
        settings.allowDiscards = true;
        content = {
          type = "btrfs";
          extraArgs = [ "-f" ];
        };

        content.subvolumes."/" = {
          inherit mountOptions;
          mountpoint = "/";
        };

        content.subvolumes."/nix" = {
          inherit mountOptions;
          mountpoint = "/nix";
        };

        content.subvolumes."/persist" = {
          inherit mountOptions;
          mountpoint = "/persist";
        };

        content.subvolumes."/swap" = {
          mountpoint = "/.swapvol";
          swap.swapfile = swap;
        };
      };
    };
  };
}
