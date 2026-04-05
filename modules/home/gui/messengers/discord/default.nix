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
        "var(--base00)" = "#${config.stylix.base16Scheme.base00}";
        "var(--base01)" = "#${config.stylix.base16Scheme.base01}";
        "var(--base02)" = "#${config.stylix.base16Scheme.base02}";
        "var(--base03)" = "#${config.stylix.base16Scheme.base03}";
        "var(--base04)" = "#${config.stylix.base16Scheme.base04}";
        "var(--base05)" = "#${config.stylix.base16Scheme.base05}";
        "var(--base06)" = "#${config.stylix.base16Scheme.base06}";
        "var(--base07)" = "#${config.stylix.base16Scheme.base07}";
        "var(--base08)" = "#${config.stylix.base16Scheme.base08}";
        "var(--base09)" = "#${config.stylix.base16Scheme.base09}";
        "var(--base0A)" = "#${config.stylix.base16Scheme.base0A}";
        "var(--base0B)" = "#${config.stylix.base16Scheme.base0B}";
        "var(--base0C)" = "#${config.stylix.base16Scheme.base0C}";
        "var(--base0D)" = "#${config.stylix.base16Scheme.base0D}";
        "var(--base0E)" = "#${config.stylix.base16Scheme.base0E}";
        "var(--base0F)" = "#${config.stylix.base16Scheme.base0F}";
      };
    in
    mkIf cfg.enable {
      "BetterDiscord/themes/stylix.theme.css".text = style;
      "vesktop/themes/stylix.theme.css".text = style;
    };
}
