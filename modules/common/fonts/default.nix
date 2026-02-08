## Add fonts to the system.
{
  pkgs,
  ...
}:
{
  fonts.packages = with pkgs; [
    open-dyslexic # objectively the best font for reading
    nerdfonts # a bunch of fonts with icons
    aurulent-sans # sans serif
    open-sans # sans serif
    carlito # Calibri
    vistafonts # Cambria, Candara, Consolas, Constantia, Corbel
    aileron # Helvetica
  ];
}
