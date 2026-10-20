{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "plugins";
  submodule = "tiny-inline-diagnostic";
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

  config.vim.extraPlugins.${submodule} = mkIf cfg.enable {
    package = pkgs.vimPlugins."${submodule}-nvim";
    setup = /* Lua */ ''
      require("${submodule}").setup({
        ["preset"] = "powerline",
        -- ["signs"] = { ["diag"] = "" }, # Breaks the prompt.
        ["options"] = {
          ["override_open_float"] = true,
          ["show_source"] = { ["enabled"] = true, },
          ["format"] = function(dialog)
            local severity = (vim.diagnostic.severity[dialog.severity]):sub(1, 1)
            local message = dialog.message
            return "[" .. severity .. "] " .. message
          end,
        },
      })
    '';
  };

  config.vim.luaConfigRC.diagnostics = mkIf cfg.enable /* Lua */ ''
    vim.diagnostic.config({
      ["virtual_text"] = false,
    })
  '';
}
