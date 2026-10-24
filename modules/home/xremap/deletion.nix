let
  DeleteAfter = key: [
    key
    "Delete"
  ];

  BackSpaceAfter = key: [
    key
    "BackSpace"
  ];
in
{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "xremap";
  submodule = "deletion";
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
      remap."Ctrl-BackSpace" = BackSpaceAfter "Shift-Home";
      remap."Ctrl-Delete" = DeleteAfter "Shift-End";
      remap."Alt-BackSpace" = BackSpaceAfter "Ctrl-Shift-Left";
      remap."Alt-Delete" = DeleteAfter "Ctrl-Shift-Right";
    };
  };
}
