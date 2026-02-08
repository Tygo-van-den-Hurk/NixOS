## Loads the settings needed for a WSL system.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
{
  machine-settings,
  input,
  ...
}:
let
  module-settings = machine-settings.system.modules.wsl;
in
if module-settings.enable then
  builtins.trace "(System) Loading: ${toString ./.}..." {
    imports = [ input.nixos-wsl.nixosModules.default ];

    wsl = {
      inherit (module-settings) enable;
      inherit (module-settings) defaultUser;
    };
  }
else
  { }
