{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "wm";
  program = "hyprlock";
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

  config.programs.${program} = mkIf cfg.enable {
    enable = mkDefault true;

    settings.general = {
      hide_cursor = true;
      ignore_empty_input = true;
    };

    settings.animations = {
      enabled = true;
      fade_in.duration = 300;
      fade_in.bezier = "easeOutQuint";
      fade_out.duration = 300;
      fade_out.bezier = "easeOutQuint";
    };

    settings.input-field = {
      valign = "bottom";
      font_size = config.stylix.fonts.sizes.desktop;
      font_family = config.stylix.fonts."sansSerif".name;
      position = "0, 50";
      size = "400, 50";
    };
  };
}
