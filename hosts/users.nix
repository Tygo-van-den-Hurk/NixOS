let
  get-sub-directories = import ./get-sub-directories.nix;
  nothing = { };
  namespace = "self";
  module = "users";
in
{
  CONFIG_PATH,
  options,
  inputs,
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
  imports = with inputs; [
    home-manager.nixosModules.default
  ];

  options.${namespace}.${module} = with types; {
    enable = mkOption {
      description = "The autofill details on users of the system from the directory structure.";
      default = true;
      type = bool;
    };

    usernames = mkOption {
      description = "The usernames to autofill details for.";
      default = get-sub-directories (CONFIG_PATH + "/users");
      type = listOf str;
    };
  };

  config = mkMerge [

    (optionalAttrs (options.${namespace} ? secrets) {
      ${namespace}.secrets.users = mkIf cfg.enable cfg.usernames;
    })

    {
      users.users = mkIf cfg.enable (
        lib.genAttrs cfg.usernames (
          username:
          let
            users = META.users or nothing;
            user = users.${username} or nothing;
          in
          {
            description = mkDefault (user.description or "Tygo van den Hurk");
            extraGroups = user.groups or [ ];
            isNormalUser = mkDefault (user.isNormalUser or true);
            linger = mkDefault (user.linger or true);
            home = mkDefault (user.home or "/home/${username}");
            createHome = mkDefault (user.createHome or true);
            homeMode = mkDefault (user.homeMode or "700");
          }
        )
      );

      home-manager = mkIf cfg.enable {
        backupFileExtension = "backup";
        extraSpecialArgs = {
          inherit (META) system;
          inherit CONFIG_PATH inputs META;
        };
        users = lib.genAttrs cfg.usernames (username: {
          imports = [
            inputs.self.homeModules.all
            (CONFIG_PATH + "/users/${username}")
          ];
        });
      };
    }
  ];
}
