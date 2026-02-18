{
  lib,
  config,
  ...
}:
with lib;
let
  type = "gui";
  category = "browsers";
  program = "firefox";
  profile = "main";
  cfg = config.${type}.${category}.${program};
in
{
  config.programs.${program}.profiles.${profile}.bookmarks = mkIf cfg.enable {
    force = mkDefault true;
    settings = [

    ];
  };
}
