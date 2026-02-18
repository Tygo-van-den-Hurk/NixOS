{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  type = "cli";
  category = "processors";
  program = "qalc";
  cfg = config.${type}.${category}.${program};
in
{
  options.${type}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${type}.${category}.enable;
      type = bool;
    };
  };

  config.programs.bash = mkIf cfg.enable {
    initExtra = ''
      ${program}_function() {
        ${pkgs.libqalculate}/bin/${program} "$@"
        local status="$?"
        set +f # enable globing
        return "$status"
      }
    '';
  };

  config.programs.zsh = mkIf cfg.enable {
    initExtra = ''
      ${program}_function() {
        ${pkgs.libqalculate}/bin/${program} "$@"
        local status="$?"
        set +f # enable globing
        return "$status"
      }
    '';
  };

  config.programs.fish = mkIf cfg.enable {
    interactiveShellInit = ''
      function ${program}_function
        ${pkgs.libqalculate}/bin/${program} "$@"
        set exit_code $status
        set +f # enable globing
        return "$exit_code"
      end
    '';
  };

  config.home = mkIf cfg.enable {
    packages = with pkgs; [ libqalculate ];
    shellAliases = rec {
      calc = "set -f; ${program}_function";
      "clac" = calc;
      "calculate" = calc;
      "calc:" = calc;
      "calculate:" = calc;
      ${program} = calc;
    };
  };
}
