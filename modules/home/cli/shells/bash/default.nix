{
  lib,
  config,
  ...
}:
with lib;
let
  program = "bash";
  category = "shells";
  type = "cli";
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
