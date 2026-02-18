{
  lib,
  config,
  ...
}:
with lib;
let
  category = "processors";
  type = "cli";
in
{
  options.${type}.${category} = with types; {
    enable = mkOption {
      description = "Whether to enable default config for the ${category} category.";
      default = config.${type}.enable;
      type = bool;
    };
  };

  imports = [
    ./jq.nix
    ./jqp.nix
    ./octave.nix
    ./qalc.nix
  ];
}
