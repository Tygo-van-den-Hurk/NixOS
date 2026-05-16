{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  module = "cli";
  category = "networking";
in
{
  options.${namespace}.${module}.${category} = with types; {
    enable = mkOption {
      description = "Whether to enable default config for the ${category} category.";
      default = config.${namespace}.${module}.enable;
      type = bool;
    };
  };
}
