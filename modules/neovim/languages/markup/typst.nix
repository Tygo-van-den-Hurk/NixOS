{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "languages";
  submodule = "markup";
  entry = "typst";
  cfg = config.${namespace}.${module}.${submodule}.${entry};
in
{
  options.${namespace}.${module}.${submodule}.${entry} = with types; {
    enable = mkOption {
      description = "Whether to enable ${entry}'s default config.";
      default = config.${namespace}.${module}.${submodule}.enable;
      type = bool;
    };
  };

  config.vim.${module}.${entry} = mkIf cfg.enable {
    enable = mkDefault true;
  };
}
