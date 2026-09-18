{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "processors";
  program = "ripgrep";
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
    arguments = [
      "--max-columns-preview"
      "--colors=line:style:bold"
    ];
  };
}
