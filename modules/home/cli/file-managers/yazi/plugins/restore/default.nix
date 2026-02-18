{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  type = "cli";
  category = "file-managers";
  program = "yazi";
  plugin = "restore";
in
{
  options.${type}.${category}.${program}.plugins.${plugin} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s ${plugin} plugin.";
      default = config.${type}.${category}.${program}.enable;
      type = bool;
    };
  };

  config.programs.${program} = mkIf config.${type}.${category}.${program}.plugins.${plugin}.enable {
    plugins.${plugin} = mkDefault pkgs.yaziPlugins.${plugin};
    initLua = mkDefault (builtins.readFile ./init.lua);
    settings.mgr.keymap = [
      {
        on = "u";
        run = "plugin restore";
        desc = "Restore last deleted files/folders";
      }
      {
        on = [
          "d"
          "u"
        ];
        run = "plugin restore";
        desc = "Restore last deleted files/folders";
      }
    ];
  };
}
