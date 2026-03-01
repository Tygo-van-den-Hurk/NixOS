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
      META,
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
      };

      config.services.openssh = mkIf cfg.enable {
        enable = mkDefault true;
        openFirewall = mkDefault false; # Tailscale goes past the firewall anyways.
        settings = {
          PermitRootLogin = mkDefault "no";
          PasswordAuthentication = mkDefault false;
          StrictModes = mkDefault true;
          UsePAM = mkDefault true;
          AllowUsers = [ META.user.username ];
        };
      };

      config.users.users = mkIf cfg.enable {
        ${META.user.username} = {
          openssh.authorizedKeys.keys = inputs.self.lib.import-recursively {
            base = ./.;
            extension = ".pub";
            transform = file: builtins.readFile file;
          };
        };
      };
    };
}
