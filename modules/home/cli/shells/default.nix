{
  lib,
  config,
  ...
}:
with lib;
let
  category = "shells";
  type = "cli";
  cfg = config.${type}.${category};
in
{
  options.${type}.${category} = with types; {
    enable = mkOption {
      description = "Whether to enable default config for the ${category} category.";
      default = config.${type}.enable;
      type = bool;
    };
  };

  config.home.shellAliases = mkIf cfg.enable rec {
    clear = mkDefault "printf \"\\e[2J\\e[3J\\e[H\"";
    c = clear;
    ckear = clear;
    ear = ":";
  };
}
