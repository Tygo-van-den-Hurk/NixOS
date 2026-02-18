{
  lib,
  config,
  ...
}:
with lib;
let
  type = "cli";
  category = "file-managers";
  program = "yazi";
  cfg = config.${type}.${category}.${program};
in
{
  config.programs.${program}.flavors = mkIf cfg.enable {

  };
}
