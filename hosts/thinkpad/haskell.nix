{
  pkgs,
  lib,
  ...
}:
with lib;
{
  home.packages = with pkgs; [
    haskell.compiler.ghc96
    haskell.packages.ghc96.haskell-language-server
    cabal-install
  ];

  programs.vscode.profiles.default = {
    userSettings = {
      "haskell.serverExecutablePath" = "haskell-language-server-wrapper";
      "haskell.formattingProvider" = "ormolu";
      "haskell.manageHLS" = "PATH";
    };

    extensions = with pkgs.vscode-extensions; [
      haskell.haskell
      justusadam.language-haskell
    ];
  };
}
