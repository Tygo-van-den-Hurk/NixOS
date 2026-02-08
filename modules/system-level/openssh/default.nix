## Enabled SSH as a service.
{
  machine-settings,
  ...
}:
let
  module-settings = machine-settings.system.modules.openssh;
in
if module-settings.enable then
  builtins.trace "(System) Loading: ${toString ./.}..." {
    services.openssh = {
      enable = true;
      settings = {
        # Enhance Security
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        openssh.settings.PermitRootLogin = "no";
      };
    };
  }
else
  { }
