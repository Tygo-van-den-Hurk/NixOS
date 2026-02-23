{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "miscellaneous";
  program = "starship";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  config.programs.${program}.settings."nix_shell" = mkIf cfg.enable {
    disabled = false;
    format = "in a [\\($state\\) $symbol]($style)";
    symbol = "Nix-Shell";
    style = "bold blue";
    impure_msg = "impure";
    pure_msg = "pure";
    unknown_msg = "unknown";
    heuristic = false;
  };
}
