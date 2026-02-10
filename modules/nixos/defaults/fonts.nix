{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkOption;
  inherit (lib) mkIf;
  inherit (lib) types;

  inherit (types) bool;

  module = "defaults";
  submodule = "fonts";
in
{
  options.${module}.${submodule}.enable = mkOption {
    description = "Whether to install common fonts like open-dyslexic.";
    default = config.${module}.enable;
    type = bool;
  };

  config.fonts = mkIf config.${module}.${submodule}.enable {
    packages = with pkgs; [
      nerd-fonts.open-dyslexic # objectively the best font for reading
      aurulent-sans # sans serif
      open-sans # sans serif
      carlito # Calibri
      vista-fonts # Cambria, Candara, Consolas, Constantia, Corbel
      aileron # Helvetica
    ];
  };
}
