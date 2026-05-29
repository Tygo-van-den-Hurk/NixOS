{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "defaults";
  submodule = "programs";
in
{
  options.${namespace}.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to fill in a bunch of defaults programs.";
      default = config.${namespace}.${module}.enable;
      readOnly = true;
      type = bool;
    };
  };
}
