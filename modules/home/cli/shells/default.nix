{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  category = "shells";
  type = "cli";
  cfg = config.${namespace}.${type}.${category};
in
{
  options.${namespace}.${type}.${category} = with types; {
    enable = mkOption {
      description = "Whether to enable default config for the ${category} category.";
      default = config.${namespace}.${type}.enable;
      type = bool;
    };
  };

  config.home.shellAliases = mkIf cfg.enable rec {
    clear = mkDefault "printf \"\\e[2J\\e[3J\\e[H\"";
    c = clear;
    ckear = clear;
    ear = "(exit $?)";
  };
}
