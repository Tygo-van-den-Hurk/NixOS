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
  program = "eza";
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
    colors = mkDefault "auto";
    enableBashIntegration = mkDefault true;
    enableFishIntegration = mkDefault true;
    enableIonIntegration = mkDefault true;
    enableNushellIntegration = mkDefault true;
    enableZshIntegration = mkDefault true;
    git = mkDefault true;
    icons = mkDefault "auto";
    theme = { };
    extraOptions = mkDefault [
      "--long"
      "--group-directories-first"
    ];
  };

  config.home.shellAliases = mkIf cfg.enable {
    la = mkDefault "${program} --group-directories-first --all";
    ll = mkDefault "${program} --group-directories-first --long";
    lla = mkDefault "${program} --group-directories-first --long --all";
    ls = mkDefault "${program} --group-directories-first --long";
    lt = mkDefault "${program} --group-directories-first --tree --all";
    tree = mkDefault "${program} --group-directories-first --tree";
  };
}
