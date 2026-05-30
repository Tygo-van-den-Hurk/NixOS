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

    # 1) Terminal applications
    Terminals.workspace = "Terminal";
    kitty = Terminals;
    gnome-terminal = Terminals;
    alacritty = Terminals;
    xterm = Terminals;

    # 2) Code/File editors
    FileEditor.workspace = "Code";
    code = FileEditor;
    VSCodium = FileEditor;
    obsidian = FileEditor;
    kate = FileEditor;
    gimp = FileEditor;
    libreoffice = FileEditor;
    DesktopEditors = FileEditor;

    # 3) Browsers
    Browser.workspace = "Browser";
    firefox = Browser;
    brave-browser = Browser;
    zen-alpha = Browser;
    zen-beta = Browser;
    zen = Browser;

    # 4) Messengers
    Messenger.workspace = "Messenger";
    discord = Messenger;
    vesktop = Messenger;
    telegram-desktop = Messenger;
    TelegramDesktop = Messenger;
    mail = Messenger;
    thunderbird = Messenger;
    signal = Messenger;
    whatsapp-for-linux = Messenger;
    wasistlos = Messenger;

    # 5) File browsers
    FileBrowser.workspace = "Files";
    "org.gnome.Nautilus" = FileBrowser;
    thunar = FileBrowser;

    # 6) Docker
    Virtualisation.workspace = "Docker";
    "VirtualBox Manager" = Virtualisation;
    "VirtualBox Machine" = Virtualisation;

    # 7) Misc
    Scratch.workspace = "Scratch";
    steamwebhelper = Scratch;
    steam = Scratch;
    obs = Scratch;
    Bitwarden = Scratch;
  };
}
