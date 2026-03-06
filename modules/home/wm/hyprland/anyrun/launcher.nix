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
  program = "anyrun";
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

  config.programs.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    inherit (cfg) package;

    config = {
      hideIcons = mkDefault true;
      maxEntries = mkDefault 10;
      y.fraction = mkDefault 0.3;
      # closeOnClick = mkDefault true;
      showResultsImmediately = mkDefault true;
      plugins = [
        "${cfg.package}/lib/libapplications.so"
        "${cfg.package}/lib/libdictionary.so"
        "${cfg.package}/lib/libwebsearch.so"
        "${cfg.package}/lib/libtranslate.so"
        "${cfg.package}/lib/libnix_run.so"
      ];
    };

    extraCss =
      with (config.stylix.base16Scheme or (throw "Stylix woopsy!"));
      let
        template = builtins.readFile ./style.gtk.css;
        replacements = {
          "var(--background-main)" = "#${base01}";
          "var(--background-secondary)" = "#${base00}";
          "var(--background-selected)" = "#${base03}";
          "var(--border-color-main)" = "#${base0D}";
          "var(--text-color-main)" = "#${base05}";
          "var(--text-color-selected)" = "#${base0D}";
          "var(--padding)" = "10px";
        };
      in
      inputs.self.lib.replaceAttrs template replacements;
  };
}
