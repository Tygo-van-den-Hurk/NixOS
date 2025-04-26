## Defines the user options.
arguments @ {
  config,
  pkgs,
  lib,
  machine-settings,
  ...
}: let
  users-from-machine-settings-to-NixOS-users = (
    username: user-settings:
    # remove attributes that Nix does not reconise
    {"${username}" = builtins.removeAttrs user-settings ["init"];}
  );
in {
  users.extraUsers = (
    lib.attrsets.concatMapAttrs
    users-from-machine-settings-to-NixOS-users
    machine-settings.users
  );
}
