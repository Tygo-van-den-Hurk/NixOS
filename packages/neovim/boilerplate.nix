# This is just to trick home manager into building neovim WITH the stylix
# modules. So we essentially have to build the "entire" home environment.
# Which should be small, but still.
{
  home.stateVersion = "26.05";
  home.username = "does-not-matter";
  home.homeDirectory = "/does-not-matter";

  self.styling.stylix.enable = true;
  self.cli.editors.neovim.enable = true;
  services.xremap.enable = false;
}
