{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  category = "fonts";
  type = "styling";
  cfg = config.${type}.${category};
in
{
  options.${type}.${category} = with types; {
    enable = mkOption {
      description = "Whether to enable default config for the ${category} category.";
      default = config.${type}.enable;
      type = bool;
    };
  };

  config.home = mkIf cfg.enable {
    packages = with pkgs; [
      nerd-fonts.open-dyslexic
      noto-fonts-color-emoji
    ];
  };
}
