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
  config.programs.${program}.settings."directory" = mkIf cfg.enable {
    disabled = false;
    truncation_length = 0;
    truncate_to_repo = true;
    fish_style_pwd_dir_length = 0;
    use_logical_path = true;
    format = "[$path]($style)$read_only";
    repo_root_format = "[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style)";
    style = "blue bold";
    read_only = " (read only)";
    read_only_style = "red";
    truncation_symbol = "";
    home_symbol = "~";
    use_os_path_sep = false;
    substitutions = { };
  };
}
