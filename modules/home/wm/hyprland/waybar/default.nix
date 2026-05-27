{
  inputs,
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "wm";
  program = "waybar";
  cfg = config.${namespace}.${type}.${program};
in
{
  options.${namespace}.${type}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.hyprland.enable;
      type = bool;
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

  config.programs.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    systemd.enable = mkDefault true;
    systemd.target = mkDefault "graphical-session.target";

    style = inputs.self.lib.replaceAttrs (builtins.readFile ./style.gtk.css) {
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

    settings.mainBar = {
      layer = "top";
      position = "top";

      modules-left = [
        "hyprland/workspaces"
      ];

      modules-center = [
        "clock"
      ];

      modules-right = [
        "bluetooth"
        "systemd-failed-units"
        "backlight"
        "pulseaudio#volume"
        "pulseaudio#microphone"
        "network#wifi"
        "custom/tailscale"
        "custom/power-button"
        "battery"
      ];
    };
  };
}
