{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "editors";
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

  config.home = mkIf cfg.enable {
    shellAliases = mkIf (config.home.sessionVariables ? "EDITOR") rec {
      e = config.home.sessionVariables."EDITOR" or null;
      editor = e;
      edit = e;
    };
  };
}
