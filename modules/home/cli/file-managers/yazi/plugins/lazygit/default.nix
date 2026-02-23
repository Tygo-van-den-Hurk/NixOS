{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "file-managers";
  program = "yazi";
  plugin = "lazygit";
  cfg = config.${namespace}.${type}.${category}.${program}.plugins.${plugin};
in
{
  options.${namespace}.${type}.${category}.${program}.plugins.${plugin} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s ${plugin} plugin.";
      default =
        config.${namespace}.${type}.${category}.${program}.enable && config.programs.${plugin}.enable;
      type = bool;
    };
  };

  config.programs.${program} = mkIf cfg.enable {
    plugins.${plugin} = mkDefault pkgs.yaziPlugins.${plugin};
    initLua = mkDefault (builtins.readFile ./init.lua);
    keymap.manager.prepend_keymap = [
      {
        on = [
          "g"
          "i"
        ];
        run = "plugin lazygit";
        desc = "run lazygit";
      }
    ];
  };
}
