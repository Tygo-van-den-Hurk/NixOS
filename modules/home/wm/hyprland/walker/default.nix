{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  type = "wm";
  program = "walker";
  cfg = config.${namespace}.${type}.${program};
in
{
  options.${namespace}.${type}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.hyprland.enable;
      type = bool;
    };

    package = mkOption {
      description = "The package to use for ${program}.";
      default = pkgs.${program};
      type = package;
    };
  };

  config.assertions = [
    {
      assertion = cfg.enable -> (config.stylix.enable or false);
      message =
        "When you enable the '${namespace}.${type}.${program}.enable' option, "
        + "then you must enable stylix for its 16 bit scheme.";
    }
  ];

  config.services.elephant = {
    enable = mkDefault true;
  };

  config.services.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    enableElephantIntegration = mkDefault true;
    systemd.enable = mkDefault true;
    inherit (cfg) package;

    settings = {
    };

    theme = {
      name = "stylix";
      style =
        with (config.lib.stylix.colors.withHashtag or (throw "Stylix woopsy!"));
        let
          template = builtins.readFile ./style.gtk.css;
          replacements = {
            "var(--base00)" = base00;
            "var(--base01)" = base01;
            "var(--base02)" = base02;
            "var(--base03)" = base03;
            "var(--base04)" = base04;
            "var(--base05)" = base05;
            "var(--base06)" = base06;
            "var(--base07)" = base07;
            "var(--base08)" = base08;
            "var(--base09)" = base09;
            "var(--base0A)" = base0A;
            "var(--base0B)" = base0B;
            "var(--base0C)" = base0C;
            "var(--base0D)" = base0D;
            "var(--base0E)" = base0E;
            "var(--base0F)" = base0F;
          };
        in
        inputs.self.lib.replaceAttrs template replacements;
    };
  };
}
