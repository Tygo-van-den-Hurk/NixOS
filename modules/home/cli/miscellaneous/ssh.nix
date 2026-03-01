{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "miscellaneous";
  program = "ssh";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  options.${namespace}.${type}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.${category}.enable;
      type = bool;
    };
  };

  config.programs.${program} = mkIf cfg.enable rec {
    enable = mkDefault true;
    enableDefaultConfig = mkDefault false;

    extraOptionOverrides = {
      identityFile = mkDefault "~/.ssh/key.private.ssh";
      identitiesOnly = mkDefault "yes";
      controlMaster = mkDefault "auto";
      controlPath = mkDefault "~/.ssh/master-%r@%n:%p";
      controlPersist = mkDefault "30m";
      SetEnv = "TERM=xterm-256color";
      SendEnv = "TERM";
    };

    matchBlocks."github" = {
      match = mkDefault "host github";
      hostname = mkDefault "github.com";
      user = mkDefault "git";
      port = mkDefault 22;
    };

    matchBlocks."NAS" = {
      match = mkDefault "host nas";
      hostname = mkDefault "tygos-nasserver.tail9fcea.ts.net";
      user = mkDefault "root";
      port = mkDefault 22;
      identitiesOnly = mkDefault false;
    };

    matchBlocks."Cloud" = {
      match = mkDefault "host cloud";
      hostname = mkDefault "cloud.tygo.van.den.hurk.dev";
      user = mkDefault "ubuntu";
      port = mkDefault 22;
      localForwards = [
        {
          bind.port = mkDefault 81;
          host.port = mkDefault 81;
          host.address = mkDefault "localhost";
        }
      ];
    };
  };
}
