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
  program = "bat";
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
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batwatch
    ];
    config = {
      map-syntax = [
        "*.drawio:XML"
      ];
    };
  };

  config.home.shellAliases = mkIf cfg.enable rec {
    cat = mkDefault "${pkgs.${program}}/bin/${program} --pager=never --style=plain --color=auto";
    ${program} = cat;
  };
}
