let
  namespace = "self";
  module = "docker";
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
          description = "Whether enable docker.";
          default = false;
          type = bool;
        };

        rootless = mkOption {
          description = "Whether to run docker rootless.";
          default = true;
          type = bool;
        };

        users = mkOption {
          description = "The users that are allowed to use docker.";
          default = config.users.groups.wheel.members;
          type = listOf str;
        };
      };

      config.virtualisation.docker = mkIf cfg.enable {
        enable = mkDefault true;
        rootless.enable = mkDefault cfg.rootless;
        autoPrune.enable = mkDefault true;
      };

      config.users.groups.docker = mkIf cfg.enable {
        members = cfg.users;
      };
    };
}
