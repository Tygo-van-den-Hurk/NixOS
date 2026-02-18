{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  type = "cli";
  category = "version-control";
  program = "git";
  cfg = config.${type}.${category}.${program};
in
{
  options.${type}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${type}.${category}.enable;
      type = bool;
    };
  };

  config.programs.${program} = mkIf cfg.enable {
    enable = mkDefault true;

    signing = {
      key = mkDefault "1AAE628A2D49059717AEA7F87CA2CBB275058A44";
      signByDefault = mkDefault true;
      format = mkDefault "openpgp";
    };

    # things to globally ignore.
    ignores = [
      "**/node_modules/"
      "**/*.zip"
      "**/*.pdf"
      "**/*.exe"
    ];

    attributes = [
      "*.pdf diff=pdf"
    ];

    settings = {

      user = {
        name = mkDefault "Tygo van den Hurk";
        email = mkDefault "91738110+Tygo-van-den-Hurk@users.noreply.github.com";
      };

      aliases = {
        "logs" = mkDefault "log --decorate=short --pretty=reference --graph";
        "s" = mkDefault "status";
        "b" = mkDefault "branch";
        "c" = mkDefault "commit";
        "l" = mkDefault "log";
        "f" = mkDefault "fetch";
        "p" = mkDefault "push";
      };

      core = {
        whitespace = mkDefault "trailing-space,space-before-tab";
        editor = mkDefault "micro";
      };

      color = {
        ui = mkDefault "auto";

        branch = {
          current = mkDefault "yellow";
          local = mkDefault "green bold";
          remote = mkDefault "blue";
        };

        diff = {
          meta = mkDefault "yellow bold";
          frag = mkDefault "magenta bold";
          old = mkDefault "red bold reverse";
          new = mkDefault "green bold reverse";
        };

        status = {
          added = mkDefault "green";
          changed = mkDefault "yellow";
          untracked = mkDefault "green reverse";
        };
      };

      url."git@github.com:".insteadOf = mkDefault "https://github.com/";
      url."git@bitbucket.org:".insteadOf = mkDefault "https://bitbucket.org/";

      push.autoSetupRemote = mkDefault true;
      init.defaultBranch = mkDefault "main";
      pager.log = mkDefault false;
    };
  };

  config.home.shellAliases = mkIf cfg.enable {
    "g" = mkDefault (getExe pkgs.${program});
  };

  imports = [
    ./delta.nix
  ];
}
