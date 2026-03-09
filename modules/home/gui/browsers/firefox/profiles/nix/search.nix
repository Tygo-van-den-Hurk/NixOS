{
  pkgs,
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
  config.programs.${program}.profiles.${profile}.search = mkIf cfg.enable {
    force = mkDefault true;
    privateDefault = mkDefault "ddg";
    default = mkDefault "ddg";
    order = mkDefault [ "ddg" ];
    engines = {

      bing.metaData.hidden = true;

      google.metaData.alias = "@g";

      ddg.metaData.alias = "@ddg";

      nix-packages = {
        name = "Nix Packages";
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@np" ];
        urls = [
          {
            template = "https://search.nixos.org/packages";
            params = [
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
      };
    };
  };
}
