{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  module = "wm";
  type = "notifications";
in
{
  options.${namespace}.${module}.${type} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${module}.enable;
      type = bool;
    };

    backend = mkOption {
      description = "Which notification backend to use.";
      default = "mako"; # "dunst";
      type = str;
    };
  };
}
