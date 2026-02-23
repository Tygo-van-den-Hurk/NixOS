{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "file-managers";
  program = "yazi";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  config.programs.${program}.settings = mkIf cfg.enable {

    # Sorting files
    mgr = {
      sort_by = mkDefault "alphabetical";
      sort_dir_first = mkDefault true;
      sort_sensitive = mkDefault false;
      sort_reverse = mkDefault false;
      sort_translit = mkDefault true;
    };

    # What to Show
    mgr = {
      show_hidden = mkDefault true;
      show_symlink = mkDefault true;
    };

    # How the preview is supposed to look
    preview = {
      wrap = mkDefault "no";
      tab_size = mkDefault 2;
    };

  };
}
