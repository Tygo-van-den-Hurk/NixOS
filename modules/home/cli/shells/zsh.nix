{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  program = "zsh";
  category = "shells";
  type = "cli";
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
    autocd = mkDefault true;
    enableCompletion = mkDefault true;
    autosuggestion = {
      enable = mkDefault true;
      highlight = mkDefault null;
      strategy = mkDefault [
        "completion"
        "history"
        "match_prev_cmd"
      ];
    };
  };
}
