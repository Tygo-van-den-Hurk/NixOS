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
  config.programs.${program}.profiles.${profile} = mkIf cfg.enable {
    name = profile;
    isDefault = mkDefault true;
    id = 0;
    preConfig = mkDefault "";
    extraConfig = mkDefault "";
    userChrome = mkDefault (builtins.readFile ./user-chrome.css);
    userContent = mkDefault (builtins.readFile ./user-content.css);
  };
}
