{ inputs, ... }:
let
  module = "styling";
in
{
  flake.homeModules.${module} =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    with lib;
    let
      cfg = config.${module};
    in
    {
      options.${module} = with types; {
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

      config = mkIf (cfg.enable == false) {
        stylix.enable = mkForce false;
        stylix.base16Scheme = {};
      };
    };
}
