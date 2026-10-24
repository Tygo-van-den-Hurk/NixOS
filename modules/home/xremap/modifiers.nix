let
  warning = "Swapping modifiers while on darwin.";
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
  submodule = "modifiers";
  cfg = config.${namespace}.${module}.${submodule};

  mkModRebind = to: {
    skip_key_event = true;
    alone = if cfg.nullify then null else [ ];
    held = to;
  };
in
{
  options.${namespace}.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to remap key/modifiers.";
      default = config.${namespace}.${module}.enable;
      type = bool;
    };

    swap = mkOption {
      description = "Whether to swap from a windows/linux layout to darwin";
      default = cfg.enable;
      type = bool;
    };

    capslock = mkOption {
      description = "Whether to remap capslock to esc.";
      default = cfg.enable;
      type = bool;
    };

    nullify = mkOption {
      description = "Whether to make them do nothing at all.";
      default = false;
      type = bool;
    };
  };

  config.services.${module}.config = mkIf cfg.enable {
    modmap =
      optionals cfg.swap [
        {
          name = "${submodule}/swap";
          mode = "enabled";
          remap = warnIf pkgs.stdenv.isDarwin warning {
            ALT_L = mkModRebind "CONTROL_L";
            ALT_R = mkModRebind "CONTROL_R";
            SUPER_L = mkModRebind "ALT_L";
            SUPER_R = mkModRebind "ALT_R";
            CONTROL_L = mkModRebind "SUPER_L";
            CONTROL_R = mkModRebind "SUPER_R";
          };
        }
      ]
      ++ optionals cfg.capslock [
        {
          name = "${submodule}/capslock";
          mode = "enabled";
          remap."CapsLock" = "Esc";
        }
      ];
  };
}
