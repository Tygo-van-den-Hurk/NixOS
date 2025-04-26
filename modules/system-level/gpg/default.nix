## Configures the GPG agent
arguments @ {
  config,
  pkgs,
  lib,
  machine-settings,
  ...
}: let
  module-settings = machine-settings.system.modules.gpg;
in (
  if module-settings.enable == true
  then
    builtins.trace "(System) Loading: ${toString ./.}..." {
      programs.gnupg = {
        package = lib.mkDefault pkgs.gnupg;
        dirmngr.enable = lib.mkDefault true;
        agent = {
          enable = lib.mkDefault true;
          settings = let
            one-week = 604800;
          in {
            default-cache-ttl = one-week;
            max-cache-ttl = one-week;
          };
        };
      };

      environment.systemPackages = with pkgs; [gnupg];
    }
  else {}
)
