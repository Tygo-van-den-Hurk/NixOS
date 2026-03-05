{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  module = "wm";
  type = "notifications";
  program = "dunst";
  cfg = config.${namespace}.${module}.${type}.${program};
in
{
  options.${namespace}.${module}.${type}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      type = bool;
      default =
        config.${namespace}.${module}.${type}.enable
        && config.${namespace}.${module}.${type}.backend == program;
    };
  };

  config.assertions = [
    {
      assertion = cfg.enable -> (config.stylix.enable or false);
      message =
        "When you enable the '${namespace}.${module}.${type}.${program}.enable' option, "
        + "then you must enable stylix for its 16 bit scheme.";
    }
    {
      assertion = cfg.enable -> config.${namespace}.${module}.${type}.backend == program;
      message =
        "When you enable the '${namespace}.${module}.${type}.${program}.enable' option, "
        + "then this must match the '${namespace}.${module}.${type}.backend' option.";
    }
  ];

  config.services.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    settings.global = {
      frame_width = mkDefault 1;
      separator_height = mkDefault 1;
    };
  };
}
