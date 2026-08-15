{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  type = "gui";
  category = "editors";
  program = "vscodium";
  profile = "default";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  config.programs.${program}.profiles.${profile} = mkIf cfg.enable {
    enableUpdateCheck = mkDefault false;
  };
}
