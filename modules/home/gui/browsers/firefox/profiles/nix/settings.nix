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
  profile = "nix";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  config.programs.${program}.profiles.${profile}.settings = mkIf cfg.enable {
    "extensions.autoDisableScopes" = 0; # Without this the addons need to be enabled manually after first install
    "sidebar.verticalTabs" = true;
    "sidebar.new-sidebar.has-used" = true;
    "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
  };
}
