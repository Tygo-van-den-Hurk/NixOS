{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  program = "bash";
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
    enableCompletion = mkDefault true;
    initExtra = builtins.readFile ./extra-init.bash;
    enable = mkDefault true;
    historyIgnore = [
      "ls"
      "preview"
      "cd"
      "cat"
      "bat"
    ];
  };
}
