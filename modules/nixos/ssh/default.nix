_:
let
  namespace = "self";
  module = "ssh";
in
{
  flake.nixosModules.${module} =
    {
      inputs,
      config,
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
          description = "Whether to allow remote logins.";
          default = false;
          type = bool;
        };

        user = mkOption {
          description = "The user you're allowed to log in as";
          default = config.${namespace}.defaults.main-user.username or null;
          type = nullOr str;
          apply =
            value:
            if value == null && cfg.enable then
              throw "Please set the '${namespace}.${module}.user' option, or enable the default user module."
            else
              value;
        };
      };

      config.services.openssh = mkIf cfg.enable {
        enable = mkDefault true;
        openFirewall = mkDefault false; # Tailscale goes past the firewall anyways.
        settings = {
          PermitRootLogin = mkDefault "no";
          PasswordAuthentication = mkDefault false;
          StrictModes = mkDefault true;
          UsePAM = mkDefault true;
          AllowUsers = [ cfg.user ];
        };
      };

      config.users.users = mkIf cfg.enable {
        ${if cfg.user != null then cfg.user else "do-not-fail"} = {
          openssh.authorizedKeys.keys = inputs.self.lib.import-recursively {
            base = ./.;
            extension = ".pub";
            transform = file: builtins.readFile file;
          };
        };
      };
    };
}
