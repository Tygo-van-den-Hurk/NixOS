{
  lib,
  config,
  ...
}:
with lib;
let
  type = "cli";
  category = "file-managers";
  program = "yazi";
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

  config.programs.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    enableBashIntegration = mkDefault true;
    enableFishIntegration = mkDefault true;
    enableNushellIntegration = mkDefault true;
    enableZshIntegration = mkDefault true;
    shellWrapperName = mkDefault program;
  };

  imports = [
    ./flavors.nix
    ./keymap.nix
    ./settings.nix
    ./theme.nix
    # plugins:
    ./plugins/git
    ./plugins/lazygit
    ./plugins/ouch
    ./plugins/restore
    ./plugins/starship
    ./plugins/sudo
  ];
}
