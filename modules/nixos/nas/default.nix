let
  server = "tygos-nasserver.tail9fcea.ts.net";
  namespace = "self";
  module = "nas";
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
          description = "Whether to mount my NAS to your system.";
          default = false;
          type = bool;
        };

        users = mkOption {
          description = "The users who will have access to the NAS.";
          default = config.users.groups.wheel.members;
          type = listOf str;
        };
      };

      config.users.groups.${server} = mkIf cfg.enable {
        name = removeSuffix ".ts.net" server;
        members = cfg.users;
      };

      config.fileSystems =
        let
          mkMount = shareName: {
            enable = mkDefault true;
            mountPoint = mkDefault "/mnt/${server}/${shareName}";
            device = mkDefault "//${server}/${shareName}";
            fsType = mkDefault "cifs";
            neededForBoot = mkDefault false;
            options = [
              "credentials=${config.sops.secrets."nas/credentials".path}"
              "x-systemd.idle-timeout=60"
              "x-systemd.device-timeout=5s"
              "x-systemd.mount-timeout=5s"
              "x-systemd.automount"
              "noauto"
              "users"
              "user"
              "uid=0"
              "gid=${toString config.users.groups.${server}.gid}"
            ];
          };
        in
        mkIf cfg.enable {
          "/mnt/${server}/documents" = mkMount "documents";
          "/mnt/${server}/media" = mkMount "media";
          "/mnt/${server}/pictures" = mkMount "pictures";
          "/mnt/${server}/projects" = mkMount "projects";
          "/mnt/${server}/school" = mkMount "school";
          "/mnt/${server}/work" = mkMount "work";
        };
    };
}
