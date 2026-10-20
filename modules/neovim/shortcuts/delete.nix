let
  insertion = "i";
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
  module = "shortcuts";
  submodule = "delete";
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

  config.vim.keymaps =
    let
      primary = if pkgs.stdenv.isDarwin then "D" else "C";
    in
    mkIf cfg.enable [
      {
        desc = "Primary + Delete => Delete until end of line";
        mode = insertion;
        key = "<${primary}-Del>";
        silent = true;
        unique = true;
        lua = true;
        action = /* Lua */ ''
          function()
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            local line = vim.api.nvim_get_current_line()
            vim.api.nvim_buf_set_text(
              0, row - 1, col, row - 1, #line, {}
            )
          end
        '';
      }
      {
        desc = "Primary + Backspace => Delete before cursor, preserve indentation";
        mode = insertion;
        key = "<${primary}-BS>";
        silent = true;
        unique = true;
        lua = true;
        action = /* Lua */ ''
          function()
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            local line = vim.api.nvim_get_current_line()
            local indent = #(line:match("^%s*") or "")
            local stop = math.max(indent, col)

            if stop > indent then
              vim.api.nvim_buf_set_text(
                0, row - 1, indent, row - 1, stop, {}
              )
              vim.api.nvim_win_set_cursor(0, {row, indent})
            end
          end
        '';
      }
    ];
}
