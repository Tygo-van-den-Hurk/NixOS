{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  namespace = "self";
  module = "defaults";
  submodule = "fonts";
  cfg = config.${namespace}.${module}.${submodule};
in
{
  options.${namespace}.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to install common fonts like open-dyslexic.";
      default = config.${namespace}.${module}.enable;
      type = bool;
    };
  };

  config.fonts = mkIf cfg.enable {
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
