{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "xremap";
  submodule = "selection";
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
        Ctrl-Shift-Left = "Shift-Home";
        Ctrl-Shift-Right = "Shift-End";
        Ctrl-Shift-Up = "Ctrl-Shift-Home";
        Ctrl-Shift-Down = "Ctrl-Shift-End";
        Alt-Shift-Left = "Ctrl-Shift-Left";
        Alt-Shift-Right = "Ctrl-Shift-Right";
        Alt-Shift-Up = "Ctrl-Shift-Up";
        Alt-Shift-Down = "Ctrl-Shift-Down";
      };
    };
  };
}
