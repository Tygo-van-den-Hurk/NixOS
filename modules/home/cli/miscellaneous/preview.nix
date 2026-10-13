{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "miscellaneous";
  program = "preview";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  options.${namespace}.${type}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.${category}.enable;
      type = bool;
    };

    package = mkOption {
      description = "What package to use for 'preview'.";
      default = inputs.self.packages.${pkgs.stdenv.system}.${program};
      type = package;
    };
  };

  config.home = mkIf cfg.enable {
    packages = [ cfg.package ];
    shellAliases = rec {
      prev = getExe cfg.package;
      p = prev;
    };
  };
}
