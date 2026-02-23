{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "gui";
  category = "browsers";
  program = "firefox";
  profile = "main";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  config.programs.${program}.profiles.${profile}.bookmarks = mkIf cfg.enable {
    force = mkDefault true;
    settings = [

    ];
  };
}
