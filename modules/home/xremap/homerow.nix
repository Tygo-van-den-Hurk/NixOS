let
  timeout_remaps = {
    F15 = "Ctrl-Alt-Super-Shift-1";
    F16 = "Ctrl-Alt-Super-Shift-2";
    F17 = "Ctrl-Alt-Super-Shift-3";
    F18 = "Ctrl-Alt-Super-Shift-4";
    F19 = "Ctrl-Alt-Super-Shift-5";
    F20 = "Ctrl-Alt-Super-Shift-6";
    F21 = "Ctrl-Alt-Super-Shift-7";
    F22 = "Ctrl-Alt-Super-Shift-8";
    F23 = "Ctrl-Alt-Super-Shift-9";
    F24 = "Ctrl-Alt-Super-Shift-0";
  };

  homerows = {
    qwerty = [
      "A"
      "S"
      "D"
      "F"
      "G"
      "H"
      "J"
      "K"
      "L"
      "SemiColon"
    ];
  };

  layouts = builtins.attrNames homerows;
in
{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "xremap";
  submodule = "homerow";
  cfg = config.${namespace}.${module}.${submodule};

  Nav = "Macro";

  mods =
    if pkgs.stdenv.isDarwin then
      [
        "CONTROL_L"
        "ALT_L"
        "SUPER_L"
        "SHIFT_L"
        Nav
        Nav
        "SHIFT_R"
        "SUPER_R"
        "ALT_R"
        "CONTROL_R"
      ]
    else
      [
        "SUPER_L"
        "ALT_L"
        "CONTROL_L"
        "SHIFT_L"
        Nav
        Nav
        "SHIFT_R"
        "CONTROL_R"
        "ALT_R"
        "SUPER_R"
      ];

  addMods = index: key: {
    name = key;
    value = {
      skip_key_event = true;
      held_threshold_millis = 250;
      held = builtins.elemAt mods index;
      alone = key;
    };
  };

  addNavActions = index: key: rec {
    name = "${Nav}-${key}";
    value = {
      remap.${name} = "Ctrl-Alt-Win-Shift-F${toString index}";
      timeout_millis = 250;
      timeout_key = "F${toString (index + 14)}";
    };
  };
in
{
  options.${namespace}.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to enable the ${submodule} shortcuts.";
      type = bool;
      default =
        config.${namespace}.${module}.enable
        && (versionOlder "0.15.8" config.services.${module}.package.version);
    };

    layout = mkOption {
      description = "The layout to pick";
      default = "qwerty";
      type = enum layouts;
    };
  };

  config.services.${module}.config = mkIf cfg.enable {
    virtual_modifiers = singleton Nav;

    modmap = singleton {
      name = "${submodule}/${cfg.layout}";
      mode = "enabled";
      remap = listToAttrs (imap0 addMods homerows.${cfg.layout});
    };

    keymap = singleton {
      name = "${submodule}/${cfg.layout}";
      mode = "enabled";
      remap = timeout_remaps // builtins.listToAttrs (imap1 addNavActions homerows.${cfg.layout});
    };
  };
}
