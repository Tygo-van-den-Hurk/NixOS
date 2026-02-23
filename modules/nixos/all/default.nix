{ inputs, ... }:
let
  namespace = "self";
  module = "all";
in
{
  flake.nixosModules.${module} =
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
          description = "Whether to enable all modules under the self namespace.";
          default = false;
          type = bool;
        };
      };

      config.${namespace} = mkIf cfg.enable {
        defaults.enable = mkDefault true;
        nas.enable = mkDefault true;
        qmk.enable = mkDefault true;
      };

      imports = with inputs.self.nixosModules; [
        defaults
        nas
        qmk
      ];
    };
}
