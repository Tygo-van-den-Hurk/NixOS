{
  inputs,
  META,
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "miscellaneous";
  program = "command-not-found";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  options.${namespace}.${type}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.${category}.enable;
      type = bool;
    };
  };

  imports = with inputs; [
    nix-index-database.homeModules.default
  ];

  config.programs.${program} = mkIf cfg.enable {
    enable = mkDefault false;
  };

  config.home.sessionVariables = mkIf cfg.enable {
    NIX_AUTO_RUN_INTERACTIVE = mkDefault "1";
    NIX_AUTO_RUN = mkDefault "1";
  };

  config.programs.nix-index = mkIf cfg.enable {
    enable = mkDefault true;
    package = mkForce inputs.nix-index-database.packages.${META.system}.nix-index-with-small-db;
  };
}
