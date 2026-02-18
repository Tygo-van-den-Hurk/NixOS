{
  lib,
  config,
  ...
}:
with lib;
let
  type = "cli";
  category = "miscellaneous";
  program = "starship";
  cfg = config.${type}.${category}.${program};
in
{
  config.programs.${program}.settings."git_metrics" = mkIf cfg.enable {
    disabled = true;
    added_style = "bold green";
    deleted_style = "bold red";
    only_nonzero_diffs = true;
    format = "([+$added]($added_style) )([-$deleted]($deleted_style) )";
    ignore_submodules = true;
  };
}
