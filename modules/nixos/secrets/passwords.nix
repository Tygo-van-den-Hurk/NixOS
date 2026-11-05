let
  nonNull = value: value != null;
in
{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "secrets";
  cfg = config.${namespace}.${module};
  inherit (config.networking) hostName;
in
{

  options.${namespace}.${module} = with types; {
    users = mkOption {
      description = "The users who need to have their passwords configured.";
      type = listOf str;
      default = [ ];
    };
  };

  config.sops.secrets = mkIf cfg.enable (

    # The passwords for each user
    (pipe cfg.users [
      (builtins.filter (user: cfg.raw.hosts.${hostName}.users.${user} or { } ? password))
      (map (user: {
        name = "hosts/${hostName}/users/${user}/password";
        value = {
          owner = config.users.users.nobody.name;
          inherit (config.users.users.nobody) group;
          neededForUsers = true;
        };
      }))
      listToAttrs
    ])
    // {

      "hosts/${hostName}/password" = mkIf (cfg.raw.hosts.${hostName} or { } ? password) {
        owner = config.users.users.nobody.name;
        inherit (config.users.users.nobody) group;
        neededForUsers = true;
      };

      "hosts/password" = mkIf (cfg.raw.hosts or { } ? password) {
        owner = config.users.users.nobody.name;
        inherit (config.users.users.nobody) group;
        neededForUsers = true;
      };
    }
  );

  config.users.extraUsers = mkIf cfg.enable (
    pipe cfg.users [
      (map (
        user:
        let
          inherit (config.sops) secrets;
          path'' = secrets."hosts/password".path or null;
          path' = secrets."hosts/${hostName}/password".path or path'';
          path = secrets."hosts/${hostName}/users/${user}/password".path or path';
        in
        if builtins.isNull path then
          null
        else
          {
            value.hashedPasswordFile = mkDefault path;
            name = user;
          }
      ))
      (builtins.filter nonNull)
      builtins.listToAttrs
    ]
  );
}
