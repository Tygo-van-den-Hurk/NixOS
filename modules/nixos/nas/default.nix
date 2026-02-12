_:
let
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
      cfg = config.${module};
    in
    {
      options.${module} = with types; {
        enable = mkOption {
          description = "Whether to mount my NAS to your system.";
          default = true;
          type = bool;
        };
      };

      config =
        let
          server = "tygos-nasserver.tail9fcea.ts.net";
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
              "uid=${toString config.users.users.${config.defaults.main-user.username}.uid}"
              "gid=0"
            ];
          };
        in
        mkIf cfg.enable {
          fileSystems."/mnt/${server}/documents" = mkMount "documents";
          fileSystems."/mnt/${server}/media" = mkMount "media";
          fileSystems."/mnt/${server}/pictures" = mkMount "pictures";
          fileSystems."/mnt/${server}/projects" = mkMount "projects";
          fileSystems."/mnt/${server}/school" = mkMount "school";
          fileSystems."/mnt/${server}/work" = mkMount "work";
        };
    };
}
