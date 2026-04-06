{
  config,
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
    userSettings = {
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "files.autoSave" = "afterDelay";
      "[nix]"."editor.tabSize" = 2;
      "workbench.tree.indent" = 16;
      "files.associations" = {
        "flake.lock" = "json";
        ".env*" = "dotenv";
      };
    };

    # file icon theme
    userSettings."workbench.iconTheme" =
      if config ? stylix then
        (if config.stylix.polarity == "dark" then "catppuccin-frappe" else "catppuccin-latte")
      else
        null;

    # ignored spellchecker words:
    userSettings."cSpell.words" = [
      "antfu"
      "bierner"
      "bradlc"
      "catppuccin"
      "dbaeumer"
      "dotenv"
      "dotjoshjohnson"
      "dreamin"
      "eamodio"
      "errorlens"
      "formulahendry"
      "jnoortheen"
      "mechatroner"
      "mhutchie"
      "oderwat"
      "pkgs"
      "ritwickdey"
      "slidev"
      "stylix"
      "tamasfe"
      "tinymist"
      "tomoki"
      "usernamehw"
      "wmaurer"
      "yoavbls"
    ];
  };
}
