{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  type = "cli";
  category = "miscellaneous";
  program = "fzf";
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
    enableBashIntegration = mkDefault true;
    enableFishIntegration = mkDefault true;
    enableZshIntegration = mkDefault true;
    tmux.enableShellIntegration = mkDefault true;
    tmux.shellIntegrationOptions = mkDefault [ ];
    defaultOptions = [
      "--height 40%"
      "--border"
    ];
  };

  config.home.shellAliases = mkIf cfg.enable {
    #! Currently broken because the `preview` package has not been copied over:
    # ${program} = "${program} --preview '${pkgs.preview}/bin/preview {}'"; 
  };
}
