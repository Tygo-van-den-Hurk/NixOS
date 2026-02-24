{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "wm";
  category = "assignments";
  cfg = config.${namespace}.${type};
in
{
  config.${namespace}.${type}.${category} = mkIf cfg.enable rec {

    # Terminal applications
    Terminals.workspace = "Terminal";
    kitty = Terminals;
    gnome-terminal = Terminals;
    alacritty = Terminals;
    xterm = Terminals;

    # Code/File editors
    FileEditor.workspace = "Code";
    code = FileEditor;
    obsidian = FileEditor;
    kate = FileEditor;
    gimp = FileEditor;
    libreoffice = FileEditor;
    DesktopEditors = FileEditor;

    # Browsers
    Browser.workspace = "Browser";
    firefox = Browser;
    brave-browser = Browser;
    zen-alpha = Browser;
    zen-beta = Browser;
    zen = Browser;

    # Messengers
    Messenger.workspace = "Messenger";
    discord = Messenger;
    telegram-desktop = Messenger;
    TelegramDesktop = Messenger;
    mail = Messenger;
    thunderbird = Messenger;
    signal = Messenger;
    whatsapp-for-linux = Messenger;

    # File browsers
    FileBrowser.workspace = "Files";
    "org.gnome.Nautilus" = FileBrowser;
    thunar = FileBrowser;

    # Docker
    Virtualisation.workspace = "Docker";
    "VirtualBox Manager" = Virtualisation;
    "VirtualBox Machine" = Virtualisation;

    # Misc
    Scratch.workspace = "Scratch";
    steamwebhelper = Scratch;
    steam = Scratch;
    obs = Scratch;
  };
}
