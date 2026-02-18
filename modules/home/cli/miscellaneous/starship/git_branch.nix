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
  config.programs.${program}.settings."git_branch" = mkIf cfg.enable {
    disabled = false;
    format = "\\([$branch]($style)(:[$remote_branch]($style))\\)";
    symbol = "";
    style = "bold yellow";
    truncation_length = 9223372036854775807;
    truncation_symbol = "...";
    only_attached = false;
    always_show_remote = false;
    ignore_branches = [ ];
  };
}
