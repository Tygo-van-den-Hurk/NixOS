{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "editors";
  program = "neovim";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  imports = with inputs; [
    nvf.homeManagerModules.default
  ];

  options.${namespace}.${type}.${category}.${program} = with types; {

    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.${category}.enable;
      type = bool;
    };

    mkDefault = mkOption {
      description = "Whether to make ${program} the default program to open its file type.";
      default = cfg.enable;
      type = bool;
    };

    wrapper = mkOption {
      description = "The wrapper to execute instead.";
      type = package;
      default = pkgs.writeShellScriptBin "vim-gui-wrapper" /* Shell */ ''
        neovim="''${neovim:-${getExe config.programs.nvf.finalPackage}}"

        # If we want the version or help, then we don't want to
        # open it in a new window, thus we just exec immediately.
        for argument in "$@"; do
          case "$argument" in
            -v | --version | -h | --help | -? )
              exec "$neovim" "$@"
            ;;
          esac
        done

        kitty='${
          if config.${namespace}.gui.terminals.kitty.enable or false then getExe pkgs.kitty else "kitty"
        }'

        # Else we wish to know if we're in a graphical environment. We want
        # to open vim in a new window if it is on a graphical environment.
        if [[ "$(tty)" == /dev/tty* ]] # on a real TTY
        then exec "$neovim" "$@"
        else # open a new terminal window instead
          exec 1>/dev/null 2>/dev/null
          nohup "$kitty" --class "NeoVim" "$neovim" "$@" &
        fi
      '';
    };

    finalPackage = mkOption {
      description = "The wrapper to execute instead.";
      type = package;
      default = pkgs.runCommand "vim-gui-wrapper-symlinks" { } /* Shell */ ''
        mkdir --parents -- "$out/bin"
        dir='${config.programs.nvf.finalPackage}'
        ln --symbolic "$dir/bin/nvf-print-config" "$out/bin/nvf-print-config"
        nvf='${getExe config.programs.nvf.finalPackage}'
        ln --symbolic "$nvf" "$out/bin/nvf"
        source='${getExe cfg.wrapper}'
        for name in 'v' 'vi' 'vim' 'nvim' 'neovim'; do
          ln --symbolic "$source" "$out/bin/$name"
          name=".$name-unwrapped"
          ln --symbolic "$nvf" "$out/bin/$name"
        done
      '';
    };
  };

  config.programs.nvf = mkIf cfg.enable {
    enable = mkDefault true;
    settings.${namespace}.all.enable = mkDefault true;
    settings.imports = [ inputs.${namespace}.neovimModules.all ];
    settings.vim.luaConfigRC."diagnostics-colors" =
      with config.lib.stylix.colors.withHashtag or { };
      mkIf (config ? stylix) /* Lua */ ''
        vim.api.nvim_set_hl(0, "DiagnosticError", { ["fg"] = "${base08}" })
        vim.api.nvim_set_hl(0, "DiagnosticWarn",  { ["fg"] = "${base09}" })
        vim.api.nvim_set_hl(0, "DiagnosticInfo",  { ["fg"] = "${base0D}" })
        vim.api.nvim_set_hl(0, "DiagnosticHint",  { ["fg"] = "${base0B}" })
      '';
  };

  config.home.sessionVariables = mkIf cfg.mkDefault {
    EDITOR = mkDefault (getExe cfg.wrapper);
  };

  config.home.packages = mkIf cfg.enable [
    # Overrides nvf's packages to instead be this the wrapper.
    (hiPrio cfg.finalPackage)
  ];
}
