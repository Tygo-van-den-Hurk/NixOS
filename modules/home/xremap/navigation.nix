{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "xremap";
  submodule = "navigation";
  cfg = config.${namespace}.${module}.${submodule};
in
{
  options.${namespace}.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to enable the ${submodule} shortcuts.";
      default = config.${namespace}.${module}.enable;
      type = bool;
    };
  };

  config.services.${module}.config = mkIf cfg.enable {
    keymap = singleton {
      name = submodule;
      exact_match = true;
      mode = "enabled";
      remap = {
        Ctrl-Left = "Home";
        Ctrl-Right = "End";
        Ctrl-Up = "Ctrl-Home";
        Ctrl-Down = "Ctrl-End";
        Alt-Left = "Ctrl-Left";
        Alt-Right = "Ctrl-Right";
        Alt-Up = "Ctrl-Up";
        Alt-Down = "Ctrl-Down";
      };
    };
  };
}
