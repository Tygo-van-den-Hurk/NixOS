{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  type = "gui";
  category = "editors";
  program = "vscode";
  profile = "default";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  config.programs.${program}.profiles.${profile} = mkIf cfg.enable {
    enableExtensionUpdateCheck = mkDefault false;
    extensions =
      with pkgs.vscode-extensions;
      [
        streetsidesoftware.code-spell-checker
        catppuccin.catppuccin-vsc-icons
        formulahendry.auto-rename-tag
        github.vscode-github-actions
        bradlc.vscode-tailwindcss
        editorconfig.editorconfig
        yoavbls.pretty-ts-errors
        astro-build.astro-vscode
        tamasfe.even-better-toml
        myriad-dreamin.tinymist
        mechatroner.rainbow-csv
        oderwat.indent-rainbow
        dbaeumer.vscode-eslint
        ritwickdey.liveserver
        usernamehw.errorlens
        # dotenv.dotenv-vscode # wants to write to `settings.json` so gives errors as nix is read only
        wmaurer.change-case
        jnoortheen.nix-ide
        bierner.color-info
        # mhutchie.git-graph # Unfree :/
        dotjoshjohnson.xml
        haskell.haskell
        eamodio.gitlens
        tomoki1207.pdf
        docker.docker
        antfu.slidev
        vue.volar
        golang.go
        jock.svg
      ]
      ++ [
        # Python and Jupyter notebooks
        ms-toolsai.jupyter-renderers
        ms-toolsai.jupyter
        ms-python.debugpy
        ms-python.pylint
        ms-python.python
      ];
  };
}
