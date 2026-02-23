{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  category = "stylix";
  type = "styling";
in
{
  options.${namespace}.${type}.${category} = with types; {
    enable = mkOption {
      description = "Whether to enable styling using the ${category} category.";
      default = config.${namespace}.${type}.enable;
      type = bool;
    };
  };

  config.${category} = mkIf config.${namespace}.${type}.${category}.enable {

    enable = mkDefault true;
    autoEnable = mkDefault true;
    polarity = mkDefault "dark";
    image = mkDefault (
      pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/Tygo-van-den-Hurk/dotfiles/e45e03c74a5628975021b85997473a01c0b96b8f/.config/assets/images/wallpapers/default.jpg";
        hash = "sha256-uXGebVUKcMNcBRduDUdwdYE3wzQSJRXXiWWM91Aavgc=";
      }
    );

    base16Scheme = mkDefault {
      base00 = "303446";
      base01 = "292c3c";
      base02 = "414559";
      base03 = "51576d";
      base04 = "626880";
      base05 = "c6d0f5";
      base06 = "f2d5cf";
      base07 = "babbf1";
      base08 = "e78284";
      base09 = "ef9f76";
      base0A = "e5c890";
      base0B = "a6d189";
      base0C = "81c8be";
      base0D = "8caaee";
      base0E = "ca9ee6";
      base0F = "eebebe";
    };

    fonts =
      with pkgs;
      mkDefault rec {
        serif = monospace;
        sansSerif = monospace;
        monospace.package = nerd-fonts.open-dyslexic;
        monospace.name = "OpenDyslexicM Nerd Font Mono";
        emoji.package = noto-fonts-color-emoji;
        emoji.name = "Noto Color Emoji";
      };
  };
}
