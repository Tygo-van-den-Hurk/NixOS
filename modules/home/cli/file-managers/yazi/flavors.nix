{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "file-managers";
  program = "yazi";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  config.programs.${program}.flavors = mkIf cfg.enable {

  };
}
