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
  program = "gh";
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
    gitCredentialHelper.enable = mkDefault true;
    settings = {
      version = mkDefault "1";
      git_protocol = mkDefault "ssh";
      prompt = mkDefault "enabled";
      pager = mkDefault "bat --style=plain --color=always --pager=never";
      aliases = {
        co = mkDefault "pr checkout";
      };
    };
  };
}
