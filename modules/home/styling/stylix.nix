{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  category = "stylix";
  type = "styling";
in
{
  options.${type}.${category} = with types; {
    enable = mkOption {
      description = "Whether to enable styling using the ${category} category.";
      default = config.${type}.enable;
      type = bool;
    };
  };

  config.${category} = mkIf config.${type}.${category}.enable {

    enable = mkDefault true;
    autoEnable = mkDefault true;
    polarity = mkDefault "dark";
    image = mkDefault (
      pkgs.fetchurl {
        url = "https://www.pixelstalk.net/wp-content/uploads/2025/06/Add-personality-to-your-desktop-by-showcasing-pink-cow-spots-design-layered-with-delicate-pastel-details.webp";
        hash = "sha256-HjY7zlLrK5PVIU2yEfB64IuMYHANQPjnvSuBE13M5m0=";
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
