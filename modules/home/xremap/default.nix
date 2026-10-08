let
  namespace = "self";
  module = "xremap";
in
{
  flake.homeModules.${module} =
    {
      inputs,
      config,
      pkgs,
      lib,
      ...
    }:
    with lib;
    let
      cfg = config.${namespace}.${module};
    in
    {
      imports = with inputs; [
        xremap.homeManagerModules.default
      ];

      options.${namespace}.${module} = with types; {
        enable = mkOption {
          description = "Whether to turn on the key remapper.";
          default = false;
          type = bool;
        };
      };

      config.services.${module} = mkIf cfg.enable {
        enable = mkDefault true;
        package = mkDefault pkgs.xremap;
        yamlConfig = builtins.readFile ./config.yaml;
      };
    };
}
