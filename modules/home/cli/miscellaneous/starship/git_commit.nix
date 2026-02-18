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
  config.programs.${program}.settings."git_commit" = mkIf cfg.enable {
    disabled = false;
    commit_hash_length = 7;
    format = "\([$tag]($style)@[$hash]($style)\) ";
    style = "green bold";
    only_detached = true;
    tag_symbol = "";
    tag_disabled = true;
    tag_max_candidates = 0;
  };
}
