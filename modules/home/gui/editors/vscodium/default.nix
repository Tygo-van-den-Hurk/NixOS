{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "gui";
  category = "editors";
  program = "vscodium";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  options.${namespace}.${type}.${category}.${program} = with types; {

    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.${category}.enable;
      type = bool;
    };

    package = mkOption {
      description = "The package to use for ${program}.";
      default = pkgs.vscodium;
      type = package;
    };

    packageName = mkOption {
      description = "The package to use for ${program}.";
      default =
        cfg.package.meta.mainProgram or (throw "No main program provided in the meta of this package.");
      type = str;
    };

    mkDefault = mkOption {
      description = "Whether to make ${program} the default program to open its file type.";
      default = cfg.enable;
      type = bool;
    };
  };

  config.programs.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    package = mkDefault cfg.package;
    mutableExtensionsDir = mkDefault false;
  };

  config.home.sessionVariables = mkIf cfg.mkDefault {
    VISUAL = mkDefault (getExe cfg.package);
  };

  config.${namespace}.wm.shortcuts.visual = mkIf cfg.mkDefault {
    key = "v";
    super = true;
    action.i3 = "exec ${getExe cfg.package}";
    action.hyprland = generators.mkLuaInline /* Lua */ ''
      hl.dsp.exec_cmd("${getExe cfg.package}")
    '';
  };

  config.home.shellAliases = mkIf cfg.mkDefault rec {
    code = cfg.packageName;
  };
}
