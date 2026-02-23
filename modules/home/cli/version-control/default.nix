{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  category = "version-control";
  type = "cli";
in
{
  options.${namespace}.${type}.${category} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.enable;
      type = bool;
    };
  };
}
