{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "ricing";
  program = "starship";
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
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableInteractive = true;
    enableIonIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    enableTransience = true;
    settings = {
      format = "$time $username@$hostname:$directory$git_branch$character ";
      right_format = "$all";
      follow_symlinks = true;
      add_newline = false;
    };
  };
}
