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
  category = "miscellaneous";
  program = "direnv";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  options.${namespace}.${type}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.${category}.enable;
      type = bool;
    };
  };

  config.programs.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    enableBashIntegration = mkDefault true;
    # enableFishIntegration = mkDefault true;
    enableNushellIntegration = mkDefault true;
    enableZshIntegration = mkDefault true;
    nix-direnv.enable = mkDefault true;
    mise.enable = mkDefault true;
    silent = mkDefault true;
    config = {

      global = {
        bash_path = mkDefault (getExe pkgs.bash);
        disable_stdin = mkDefault true;
        load_dotenv = mkDefault false;
        strict_env = mkDefault true;
        warn_timeout = mkDefault config.home.sessionVariables.DIRENV_WARN_TIMEOUT;
        hide_env_diff = mkDefault true;
      };

      whitelist = {
        prefix = [
          "~/Projects/Tygo-van-den-Hurk"
          "~/Projects/school-Tygo-van-den-Hurk"
          "~/Projects/homelab-Tygo-van-den-Hurk"
          "~/Projects/legacy-Tygo-van-den-Hurk"
          "~/Projects/SAFS"
        ];
      };
    };
  };

  config.home.sessionVariables = mkIf cfg.enable {
    DIRENV_WARN_TIMEOUT = mkDefault "-1.5h"; # disabled
  };
}
