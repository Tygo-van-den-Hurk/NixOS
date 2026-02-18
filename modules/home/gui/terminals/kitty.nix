{
  lib,
  config,
  system,
  ...
}:
with lib;
let
  type = "gui";
  category = "terminals";
  program = "kitty";
  cfg = config.${type}.${category}.${program};
in
{
  options.${type}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${type}.${category}.enable;
      type = bool;
    };

    mkDefault = mkOption {
      description = "Whether to make ${program} the default program to open its file type.";
      default = config.${type}.${category}.${program}.enable;
      type = bool;
    };
  };

  config.programs.${program} = mkIf cfg.enable {
    enable = mkDefault true;
    enableGitIntegration = mkDefault config.programs.git.enable;

    shellIntegration = {
      enableBashIntegration = mkDefault true;
      enableFishIntegration = mkDefault true;
      enableZshIntegration = mkDefault true;
      mode = mkDefault "no-rc";
    };

    keybindings =
      if (hasSuffix "linux" system) then
        {
          "ctrl+c" = mkDefault "copy_or_interrupt";
          "super+c" = mkDefault "signal_child SIGINT";
          "ctrl+v" = mkDefault "paste_from_clipboard";
        }
      else
        { };

    settings = {

      # general
      confirm_os_window_close = mkDefault "0";
      copy_on_select = mkDefault "no";
      enable_audio_bell = mkDefault "yes";

      # looks
      padding_width = mkDefault "0";

      # Cursors
      cursor_shape = mkDefault "beam";
      cursor_shape_unfocused = mkDefault "hollow";

      # URLs
      detect_urls = mkDefault "yes";
      open_url_with = mkDefault "default";
      underline_hyperlinks = mkDefault "always";
    };
  };

  config.home.sessionVariables = mkIf cfg.mkDefault {
    TERMINAL = mkDefault "${getExe pkgs.${program}}";
  };
}
