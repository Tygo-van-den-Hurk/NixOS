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
  plugin = "ouch";
in
{
  options.${namespace}.${type}.${category}.${program}.plugins.${plugin} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s ${plugin} plugin.";
      default = config.${namespace}.${type}.${category}.${program}.enable;
      type = bool;
    };
  };

  config.home = mkIf config.${namespace}.${type}.${category}.${program}.plugins.${plugin}.enable {
    packages = [ pkgs.${plugin} ];
  };

  config.programs.${program} =
    mkIf config.${namespace}.${type}.${category}.${program}.plugins.${plugin}.enable
      {
        plugins.${plugin} = mkDefault pkgs.yaziPlugins.${plugin};
        initLua = mkDefault (builtins.readFile ./init.lua);
        settings.opener.extract = [
          {
            run = "ouch d -y %*";
            desc = "Extract here with ouch";
            for = "windows";
          }
          {
            run = "ouch d -y \"\$@\"";
            desc = "Extract here with ouch";
            for = "unix";
          }
        ];

        keymap.mgr.prepend_keymap = [
          {
            on = [ "C" ];
            run = "plugin ouch";
            desc = "Compress with ouch";
          }
        ];
      };
}
