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
  plugin = "sudo";
in
{
  options.${namespace}.${type}.${category}.${program}.plugins.${plugin} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s ${plugin} plugin.";
      default = config.${namespace}.${type}.${category}.${program}.enable;
      type = bool;
    };
  };

  config.programs.${program} =
    mkIf config.${namespace}.${type}.${category}.${program}.plugins.${plugin}.enable
      {
        plugins.${plugin} = mkDefault pkgs.yaziPlugins.${plugin};
        initLua = mkDefault (builtins.readFile ./init.lua);
        keymap.mgr.keymap = [
          {
            on = [
              "R"
              "p"
              "p"
            ];
            run = "plugin sudo -- paste";
            desc = "sudo paste";
          }
          {
            on = [
              "R"
              "P"
            ];
            run = "plugin sudo -- paste --force";
            desc = "sudo paste";
          }
          {
            on = [
              "R"
              "r"
            ];
            run = "plugin sudo -- rename";
            desc = "sudo rename";
          }
          {
            on = [
              "R"
              "p"
              "l"
            ];
            run = "plugin sudo -- link";
            desc = "sudo link";
          }
          {
            on = [
              "R"
              "p"
              "r"
            ];
            run = "plugin sudo -- link --relative";
            desc = "sudo link relative path";
          }
          {
            on = [
              "R"
              "p"
              "L"
            ];
            run = "plugin sudo -- hardlink";
            desc = "sudo hardlink";
          }
          {
            on = [
              "R"
              "a"
            ];
            run = "plugin sudo -- create";
            desc = "sudo create";
          }
          {
            on = [
              "R"
              "d"
            ];
            run = "plugin sudo -- remove";
            desc = "sudo trash";
          }
          {
            on = [
              "R"
              "D"
            ];
            run = "plugin sudo -- remove --permanently";
            desc = "sudo delete";
          }
        ];
      };
}
