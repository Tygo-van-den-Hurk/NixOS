{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "version-control";
  program = "gh-dash";
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

  config.programs.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    settings = rec {
      issuesLimit = mkDefault 20;
      prsLimit = mkDefault issuesLimit;
      refetchIntervalMinutes = mkDefault 30;
      prApproveComment = mkDefault "Looks good to me!";
      view = mkDefault "prs";
      preview = {
        open = mkDefault true;
        width = mkDefault 50;
      };
    };
  };
}
