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
  config.programs.${program}.settings."git_state" = mkIf cfg.enable {
    disabled = false;
    rebase = "REBASING";
    merge = "MERGING";
    revert = "REVERTING";
    cherry_pick = "CHERRY-PICKING";
    bisect = "BISECTING";
    am = "AM";
    am_or_rebase = "AM/REBASE";
    style = "bold yellow";
    format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
  };
}
