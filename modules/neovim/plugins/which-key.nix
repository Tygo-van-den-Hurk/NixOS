{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "plugins";
  submodule = "which-key";
  cfg = config.${namespace}.${module}.${submodule};
in
{
  options.${namespace}.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to enable ${submodule}'s default config.";
      default = config.${namespace}.${module}.enable;
      type = bool;
    };
  };

  config.vim.binds."whichKey" = mkIf cfg.enable {
    enable = mkDefault true;
  };

  config.vim.ui.borders.plugins.${submodule} = mkIf cfg.enable {
    enable = mkDefault true;
  };
}
