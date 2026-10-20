{
  inputs,
  ...
}:
let
  namespace = "self";
  module = "all";
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
          description = "Whether to enable all neovim modules";
          default = false;
          type = bool;
        };
      };

      imports = with inputs.self.neovimModules; [
        languages
        plugins
        shortcuts
      ];

      config.${namespace} = mkIf cfg.enable {
        languages.enable = mkDefault true;
        plugins.enable = mkDefault true;
        shortcuts.enable = mkDefault true;
      };
    };
}
