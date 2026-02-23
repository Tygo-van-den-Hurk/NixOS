{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "version-control";
  program = "git";
  helper = "delta";
  cfg = config.${namespace}.${type}.${category}.${program}.${helper};
in
{
  options.${namespace}.${type}.${category}.${program}.${helper} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.${category}.enable;
      type = bool;
    };
  };

  config.programs.${program} = mkIf cfg.enable {
    settings.merge.conflictstyle = mkDefault "zdiff3";
  };

  config.programs.${helper} = mkIf cfg.enable {
    enable = mkDefault true;
    options = {
      line-numbers = mkDefault true;
      hyperlinks = mkDefault true;
      hyperlinks-file-link-format = mkDefault "vscode://file/{path}:{line}";
      side-by-side = mkDefault true;
      line-numbers-left-format = mkDefault "";
      line-numbers-right-format = mkDefault "│ ";
    };
  };
}
