{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "gui";
  category = "terminals";
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
