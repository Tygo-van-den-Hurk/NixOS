_:
let
  namespace = "self";
  module = "docker";
in
{
  flake.nixosModules.${module} =
    {
      config,
      META,
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
      };

      config.virtualisation.docker = mkIf cfg.enable {
        enable = mkDefault true;
        rootless.enable = mkDefault cfg.rootless;
        autoPrune.enable = mkDefault true;
      };

      config.users.groups.docker = mkIf cfg.enable {
        members = [ META.user.username ];
      };
    };
}
