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
  config.programs.${program}.settings."git_status" = mkIf cfg.enable {
    disabled = false;
    format = "(\\[[$all_status$ahead_behind]($style)\\] )";
    style = "red bold";
    stashed = "\\$";
    ahead = "⇡";
    behind = "⇣";
    up_to_date = "";
    diverged = "⇕";
    conflicted = "=";
    deleted = "✘";
    renamed = "»";
    modified = "!";
    staged = "+";
    untracked = "?";
    typechanged = "";
    ignore_submodules = true;
    use_git_executable = false;
  };
}
