## installs virtual box, and configures the sytem to run it
{
  pkgs,
  lib,
  machine-settings,
  ...
}:
let

  inherit (lib) mkDefault;

  users-with-this-module-enabled = lib.attrNames (
    lib.attrsets.concatMapAttrs (
      user-name: user-settings:
      if user-settings.init.modules.docker.enable then { "${user-name}" = user-settings; } else { }
    ) machine-settings.users
  );
in
if (builtins.length users-with-this-module-enabled) > 0 then
  (builtins.trace "(System) Loading: ${toString ./.}..." {
    users.extraGroups.docker.members = builtins.trace "(System) Loading: ${builtins.toJSON users-with-this-module-enabled}..." users-with-this-module-enabled;

    environment.systemPackages = with pkgs; [
      docker
      docker-compose
    ];

    virtualisation.docker = rec {
      enable = mkDefault true;
      rootless = {
        enable = mkDefault true;
        setSocketVariable = mkDefault true;
      };
    };
  })
else
  { }
