{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "plugins";
  submodule = "ccc";
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

  config.vim.utility.${submodule} = mkIf cfg.enable {
    enable = mkDefault true;
    setupOpts.alpha_show = mkDefault "show";
  };
}
