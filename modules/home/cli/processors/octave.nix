{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "processors";
  program = "octave";
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

  config.home = mkIf cfg.enable {
    shellAliases.${program} = mkDefault "${pkgs.${program}}/bin/${program} --silent";

    file.".octaverc".text = mkDefault ''
      # Run by octave every time the program starts

      #| Load all packages installed
      pkg load linear-algebra
      pkg load symbolic

      #| go to the documents folder
      cd("~/Documents");
    '';

    packages = with pkgs; [
      (octave.withPackages (
        octavePackages: with octavePackages; [
          # ( Adding some extensions to octave )
          symbolic # Adds the ability for symbolic variables and calculations to Octave
          linear-algebra # Adds more linear algebra functions to Octave
        ]
      ))
    ];
  };
}
