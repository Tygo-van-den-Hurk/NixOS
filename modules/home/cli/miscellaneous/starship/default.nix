{
  lib,
  config,
  ...
}:
with lib;
let
  type = "cli";
  category = "miscellaneous";
  program = "starship";
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
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableInteractive = true;
    enableIonIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    enableTransience = true;
    settings = {
      format = "$time $username@$hostname:$directory$git_branch$character ";
      right_format = "$all";
      follow_symlinks = true;
      add_newline = false;
    };
  };

  imports = [
    ./c.nix
    ./character.nix
    ./cpp.nix
    ./directory.nix
    ./git_branch.nix
    ./git_commit.nix
    ./git_metrics.nix
    ./git_state.nix
    ./git_status.nix
    ./hostname.nix
    ./nix_shell.nix
    ./nodejs.nix
    ./os.nix
    ./python.nix
    ./rust.nix
    ./time.nix
    ./typst.nix
    ./username.nix
  ];
}
