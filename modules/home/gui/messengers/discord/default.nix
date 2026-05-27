{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  type = "gui";
  category = "messengers";
  program = "discord";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  options.${namespace}.${type}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.${category}.enable;
      type = bool;
    };

    package = mkOption {
      description = "The package to use for ${program}";
      default = pkgs.vesktop;
      type = package;
    };
  };

  config.self.unfree = mkIf cfg.enable {
    packageAllowList = [
      "discord"
    ];
  };

  config.home = mkIf cfg.enable {
    packages = with pkgs; [
      config.${namespace}.${type}.${category}.${program}.package
    ];
  };

  config.xdg.configFile =
    let
      style = inputs.self.lib.replaceAttrs (builtins.readFile ./style.web.css) {
        "var(--base00)" = "${config.lib.stylix.colors.withHashtag.base00}";
        "var(--base01)" = "${config.lib.stylix.colors.withHashtag.base01}";
        "var(--base02)" = "${config.lib.stylix.colors.withHashtag.base02}";
        "var(--base03)" = "${config.lib.stylix.colors.withHashtag.base03}";
        "var(--base04)" = "${config.lib.stylix.colors.withHashtag.base04}";
        "var(--base05)" = "${config.lib.stylix.colors.withHashtag.base05}";
        "var(--base06)" = "${config.lib.stylix.colors.withHashtag.base06}";
        "var(--base07)" = "${config.lib.stylix.colors.withHashtag.base07}";
        "var(--base08)" = "${config.lib.stylix.colors.withHashtag.base08}";
        "var(--base09)" = "${config.lib.stylix.colors.withHashtag.base09}";
        "var(--base0A)" = "${config.lib.stylix.colors.withHashtag.base0A}";
        "var(--base0B)" = "${config.lib.stylix.colors.withHashtag.base0B}";
        "var(--base0C)" = "${config.lib.stylix.colors.withHashtag.base0C}";
        "var(--base0D)" = "${config.lib.stylix.colors.withHashtag.base0D}";
        "var(--base0E)" = "${config.lib.stylix.colors.withHashtag.base0E}";
        "var(--base0F)" = "${config.lib.stylix.colors.withHashtag.base0F}";
      };
    in
    mkIf cfg.enable {
      "BetterDiscord/themes/stylix.theme.css".text = style;
      "vesktop/themes/stylix.theme.css".text = style;
    };
}
