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
  type = "gui";
  category = "editors";
  program = "vscodium";
  profile = "default";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  config.nixpkgs = mkIf cfg.enable {
    overlays = with inputs.nix-vscode-extensions; [
      overlays.default
    ];
  };

  config.programs.${program}.profiles.${profile} = mkIf cfg.enable {
    enableExtensionUpdateCheck = mkDefault false;
    extensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
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
      rust-lang.rust-analyzer
      oderwat.indent-rainbow
      dbaeumer.vscode-eslint
      ritwickdey.liveserver
      usernamehw.errorlens
      wmaurer.change-case
      jnoortheen.nix-ide
      bierner.color-info
      dotjoshjohnson.xml
      eamodio.gitlens
      tomoki1207.pdf
      docker.docker
      antfu.slidev
      vue.volar
      golang.go
      jock.svg
      # Python and Jupyter notebooks
      ms-toolsai.jupyter-renderers
      ms-toolsai.jupyter
      ms-python.debugpy
      ms-python.pylint
      ms-python.python
    ];
  };
}
