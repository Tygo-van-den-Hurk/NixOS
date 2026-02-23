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
  plugin = "starship";
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
      };
}
