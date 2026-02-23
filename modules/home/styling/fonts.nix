{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  namespace = "self";
  category = "fonts";
  type = "styling";
  cfg = config.${namespace}.${type}.${category};
in
{
  options.${namespace}.${type}.${category} = with types; {
    enable = mkOption {
      description = "Whether to enable default config for the ${category} category.";
      default = config.${namespace}.${type}.enable;
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
