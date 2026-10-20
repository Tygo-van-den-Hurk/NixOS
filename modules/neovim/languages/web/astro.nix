{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "languages";
  submodule = "web";
  entry = "astro";
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

  config.vim.lsp.servers."${entry}-language-server" = mkIf cfg.enable {
    init_options.typescript.tsdk = mkDefault "${pkgs.typescript}/lib/node_modules/typescript/lib";
  };
}
