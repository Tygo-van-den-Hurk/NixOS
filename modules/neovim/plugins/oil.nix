{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "plugins";
  submodule = "oil";
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

  config.vim.utility."oil-nvim" = mkIf cfg.enable {
    enable = mkDefault true;
    gitStatus.enable = mkDefault true;
  };

  config.vim.luaConfigRC = mkIf cfg.enable {
    oil-explore-backwards-compatibility = /* Lua */ ''
      vim.api.nvim_create_user_command("Explore", "Oil", {})
      vim.api.nvim_create_user_command("Ex", "Oil", {})
    '';
  };
}
