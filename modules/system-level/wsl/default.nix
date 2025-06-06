## Loads the settings needed for a WSL system.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
arguments @ {
  config,
  pkgs,
  lib,
  machine-settings,
  programs,
  input,
  ...
}: let
  module-settings = machine-settings.system.modules.wsl;
in (
  if module-settings.enable == true
  then
    builtins.trace "(System) Loading: ${toString ./.}..." {
      imports = [input.nixos-wsl.nixosModules.default];

      wsl = {
        enable = module-settings.enable;
        defaultUser = module-settings.defaultUser;
      };
    }
  else {}
)
