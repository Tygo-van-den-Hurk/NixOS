{ inputs, ... }:
let
  namespace = "self";
  module = "impermanence";
in
{
  flake.nixosModules.${module} =
    {
      config,
      lib,
      ...
    }:
    with lib;
    let
      cfg = config.${namespace}.${module};
    in
    {
      options.${namespace}.${module} = with types; {
        enable = mkOption {
          description = "Whether make root file system ephemeral.";
          default = false;
          type = bool;
        };

        persistentStoragePath = mkOption {
          description = "Where to keep persistent data.";
          default = "/persistent/system";
          type = str;
        };

        bootDeviceID = mkOption {
          description = "The id of the boot drive.";
          default = null;
          type = nullOr (strMatching "[A-Z0-9]{4}-[A-Z0-9]{4}");
        };

        deleteAfterDays = mkOption {
          description = "Delete any version of this final tree after x days.";
          default = 30;
          type = int;
        };
      };

      config.environment.persistence = mkIf cfg.enable {
        system = {
          enable = mkDefault true;
          hideMounts = mkDefault true;
          inherit (cfg) persistentStoragePath;
          directories = [
            "/etc/nixos"
            "/var/lib/nixos"
            "/var/lib/bluetooth"
            "/etc/NetworkManager/system-connections"
            "/var/lib/systemd/coredump"
            "/home"
          ];

          files = [
            "/etc/machine-id"
          ];
        };
      };

      config.fileSystems = mkIf cfg.enable {
        "/" = {
          device = mkDefault "/dev/root_vg/root";
          fsType = mkDefault "btrfs";
          options = [ "subvol=root" ];
        };

        "/boot" = {
          device = mkDefault "/dev/disk/by-uuid/${cfg.bootDeviceID}";
          fsType = mkDefault "vfat";
        };

        ${cfg.persistentStoragePath} = {
          device = mkDefault "/dev/root_vg/root";
          neededForBoot = mkDefault true;
          fsType = mkDefault "btrfs";
          options = [ "subvol=persistent" ];
        };

        "/nix" = {
          device = mkDefault "/dev/root_vg/root";
          fsType = mkDefault "btrfs";
          options = [ "subvol=nix" ];
        };
      };

      config.boot.initrd = mkIf cfg.enable {
        postResumeCommands = mkAfter ''
          mkdir /btrfs_tmp
          mount /dev/root_vg/root /btrfs_tmp
          if [[ -e /btrfs_tmp/root ]]; then
            mkdir -p /btrfs_tmp/old_roots
            timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
            mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
          fi

          delete_subvolume_recursively() {
            IFS=$'\n'
            for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
            done
            btrfs subvolume delete "$1"
          }

          for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +${toString cfg.deleteAfterDays}); do
            delete_subvolume_recursively "$i"
          done

          btrfs subvolume create /btrfs_tmp/root
          umount /btrfs_tmp
        '';
      };

      imports = [
        inputs.impermanence.nixosModules.impermanence
      ];

      config.assertions = [
        {
          assertion = cfg.enable -> cfg.bootDeviceID != null;
          message =
            "When you enable the '${namespace}.${module}.enable' option, "
            + "then you must fill in the device for /boot "
            + "using '${namespace}.${module}.bootDeviceID'.";
        }
      ];
    };
}
