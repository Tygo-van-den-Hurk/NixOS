{

  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "languages";
  submodule = "web";
  cfg = config.${namespace}.${module};
in
{
  options.${namespace}.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to turn on the language module for all ${submodule} languages.";
      default = cfg.enable;
      type = bool;
    };
  };
}
