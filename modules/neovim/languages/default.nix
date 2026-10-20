{
  inputs,
  ...
}:
let
  inherit (inputs.self.lib) find-files;
  namespace = "self";
  module = "languages";
in
{
  flake.neovimModules.${module} =
    {
      config,
      lib,
      ...
    }:
    with lib;
    let
      cfg = config.${namespace}.${module};
    in
    {
      options.${namespace}.${module} = with types; {
        enable = mkOption {
          description = "Whether to turn on the language module.";
          default = false;
          type = bool;
        };
      };

      imports = find-files {
        base = ./.;
        exclude = ./default.nix;
        extension = ".nix";
      };

      config.vim = mkIf cfg.enable {
        lsp.enable = mkDefault true;
        treesitter.enable = mkDefault true;
        languages.enableTreesitter = mkDefault true;
      };
    };
}
