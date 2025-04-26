## Manages the users dot files
arguments @ {
  config,
  pkgs,
  lib,
  machine-settings,
  programs,
  input,
  ...
}: let
  users-with-this-module-enabled = lib.attrNames (lib.attrsets.concatMapAttrs (
      user-name: user-settings:
        if user-settings.init.modules.home-manager.enable == true
        then {"${user-name}" = user-settings;}
        else {}
    )
    machine-settings.users);
in (
  if (builtins.length users-with-this-module-enabled) > 0
  then
    (builtins.trace "(System) Loading: ${toString ./.}..." {
      imports = [
        input.home-manager.nixosModules.home-manager
        input.stylix.nixosModules.stylix
      ];

      stylix = {
        # enable = true;
        homeManagerIntegration.followSystem = false;
        # image = lib.mkForce ./default.png;
      };

      home-manager = {
        backupFileExtension = lib.mkForce "backup";
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit input;};
        users = let
          # The users home-manager configurations
          home-manager-configurations = (
            lib.attrsets.concatMapAttrs (
              __username_: __user_settings_: (
                if (__user_settings_.init.modules.home-manager.enable == true)
                then {
                  "${__username_}" = import input."${__user_settings_.init.modules.home-manager.configPath}";
                }
                else {}
              )
            )
            machine-settings.users
          );
        in (
          builtins.trace "(System) Loading: Home-Manager configurations: ${
            builtins.toJSON (builtins.attrNames home-manager-configurations)
          }..."
          home-manager-configurations
        );
      };
    })
  else {}
)
