## Defines the configuration options for this machine.
#! You should not have to change this file, all changes should happen in either the modules, or the settings.
arguments @ {
  config,
  pkgs,
  lib,
  programs,
  input,
  ...
}: {
  systemd.network.wait-online.enable = lib.mkForce false;
  boot.initrd.systemd.network.wait-online.enable = lib.mkForce false;

  environment.etc."nixos/active".text = config.system.nixos.label;

  fileSystems = let
    mountShareFromTygosNasServer = let
      server = "tygos-nasserver.tail9fcea.ts.net";
    in (shareName: {
      "/mnt/${server}/${shareName}" = {
        device = "//${server}/${shareName}";
        fsType = "cifs";
        options = let
          timeouts = "x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
          general = "x-systemd.automount,noauto,${timeouts},user,users";
          credentials = "credentials=${config.sops.secrets."tygo-van-den-hurk/nas/personal/credentials".path}";
          premissions = "uid=${toString config.users.users.tygo.uid},gid=0";
        in ["${general},${credentials},${premissions}"];
      };
    });
  in (
    (mountShareFromTygosNasServer "documents")
    // (mountShareFromTygosNasServer "media")
    // (mountShareFromTygosNasServer "pictures")
    // (mountShareFromTygosNasServer "projects")
    // (mountShareFromTygosNasServer "school")
    // (mountShareFromTygosNasServer "work")
  );
}
