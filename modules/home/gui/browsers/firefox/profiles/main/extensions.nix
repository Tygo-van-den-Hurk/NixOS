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
  config.programs.${program}.profiles.${profile}.extensions = mkIf cfg.enable {
    force = mkDefault false;
    settings = {
      # <name>.force	Forcibly override any existing configuration for this extension. 	boolean
      # <name>.settings	Json formatted options for the specified extensionID	attribute set of (JSON value)
    };
  };
}
