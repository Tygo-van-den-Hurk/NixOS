{
  inputs,
  ...
}:
let
  inherit (inputs.self.lib) find-files;
  namespace = "self";
  module = "ssh";
in
{
  flake.nixosModules.${module} =
    {
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

      config.services.fail2ban = mkIf cfg.enable {
        enable = mkDefault true;
        maxretry = mkDefault 5;
        bantime = mkDefault "24h";
        ignoreIP = [ "100.64.0.0/10" ];
      };

      config.services.endlessh = mkIf cfg.enable {
        enable = mkDefault true;
        openFirewall = mkDefault true;
        port = mkDefault 2222;
      };

      config.users.users = mkIf cfg.enable {
        ${META.user.username} = {
          openssh.authorizedKeys.keys = find-files {
            base = ./.;
            extension = ".pub";
            transform = builtins.readFile;
          };
        };
      };
    };
}
