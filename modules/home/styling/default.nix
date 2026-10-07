{
  inputs,
  ...
}:
let
  inherit (inputs.self.lib) find-files;
  namespace = "self";
  module = "styling";
in
{
  flake.homeModules.${module} =
    {
      inputs,
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
          description = "Whether to enable styling of all tools.";
          default = false;
          type = bool;
        };
      };

      imports = find-files {
        base = ./.;
        exclude = ./default.nix;
        extension = ".nix";
        extra = with inputs; [
          stylix.homeModules.stylix
        ];
      };

      config = mkIf (!cfg.enable) {
        stylix.enable = mkForce false;
        stylix.base16Scheme = { };
      };
    };
}
