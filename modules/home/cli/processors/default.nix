{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  category = "processors";
  type = "cli";
in
{
  options.${namespace}.${type}.${category} = with types; {
    enable = mkOption {
      description = "Whether to enable default config for the ${category} category.";
      default = config.${namespace}.${type}.enable;
      type = bool;
    };
  };
}
