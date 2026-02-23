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
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  # [See list of policies](https://mozilla.github.io/policy-templates/). Attribute set of (JSON value)
  config.programs.${program}.policies = mkIf cfg.enable {
    BlockAboutConfig = mkDefault true;
    BlockAboutProfiles = mkDefault true;
    BlockAboutSupport = mkDefault true;
  };
}
