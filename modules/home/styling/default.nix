{ inputs, ... }:
let
  namespace = "self";
  module = "styling";
in
{
  flake.homeModules.${module} =
    {
      lib,
      config,
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

      imports = inputs.self.lib.import-recursively {
        base = ./.;
        exclude = ./default.nix;
        extra = [ inputs.stylix.homeModules.stylix ];
      };

      config = mkIf (!cfg.enable) {
        stylix.enable = mkForce false;
        stylix.base16Scheme = { };
      };
    };
}
