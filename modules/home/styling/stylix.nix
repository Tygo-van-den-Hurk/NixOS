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

    image =
      with pkgs;
      stdenv.mkDerivation rec {
        name = "wallpaper.png";

        nativeBuildInputs = [ python312Packages.cairosvg ];

        inherit (config.stylix.base16Scheme) base00;
        inherit (config.stylix.base16Scheme) base01;
        inherit (config.stylix.base16Scheme) base02;
        inherit (config.stylix.base16Scheme) base03;
        inherit (config.stylix.base16Scheme) base04;
        inherit (config.stylix.base16Scheme) base05;
        inherit (config.stylix.base16Scheme) base06;
        inherit (config.stylix.base16Scheme) base07;
        inherit (config.stylix.base16Scheme) base08;
        inherit (config.stylix.base16Scheme) base09;
        inherit (config.stylix.base16Scheme) base0A;
        inherit (config.stylix.base16Scheme) base0B;
        inherit (config.stylix.base16Scheme) base0C;
        inherit (config.stylix.base16Scheme) base0D;
        inherit (config.stylix.base16Scheme) base0E;
        inherit (config.stylix.base16Scheme) base0F;

        # resolution: 4K
        height = toString (1080 * 2);
        width = toString (1920 * 2);

        src = /* XML */ ''
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="-3147.3225303193467 -2992.9837954790196 11119.632365326193 5985.967590958039"
            x-adapted-from="https://brand.nixos.org/logos/nixos-logo-rainbow-gradient-black-regular-horizontal-recommended.svg">
            <defs>
              <linearGradient gradientUnits="userSpaceOnUse" id="linear-gradient-44584babfef90c4cb32c8ee42b1193ba" x1="-319.9999999999999" x2="127.99999999999996" y1="-554.2562584220408" y2="221.70250336881628">
                <stop offset="0%"   stop-color="$base08" />
                <stop offset="25%"  stop-color="$base08" />
                <stop offset="100%" stop-color="$base08" />
              </linearGradient>
              <linearGradient gradientUnits="userSpaceOnUse" id="linear-gradient-96af2d924a4fbf5b015c244addc578a8" x1="-319.9999999999999" x2="127.99999999999996" y1="-554.2562584220408" y2="221.70250336881628">
                <stop offset="0%"   stop-color="$base09" />
                <stop offset="25%"  stop-color="$base09" />
                <stop offset="100%" stop-color="$base09" />
              </linearGradient>
              <linearGradient gradientUnits="userSpaceOnUse" id="linear-gradient-33ff75d118a188d564af252422e7cc92" x1="-319.9999999999999" x2="127.99999999999996" y1="-554.2562584220408" y2="221.70250336881628">
                <stop offset="0%"   stop-color="$base0A" />
                <stop offset="25%"  stop-color="$base0A" />
                <stop offset="100%" stop-color="$base0A" />
              </linearGradient>
              <linearGradient gradientUnits="userSpaceOnUse" id="linear-gradient-2a0b6b52f041088f95dc76196e6b4d88" x1="-319.9999999999999" x2="127.99999999999996" y1="-554.2562584220408" y2="221.70250336881628">
                <stop offset="0%"   stop-color="$base0B" />
                <stop offset="25%"  stop-color="$base0B" />
                <stop offset="100%" stop-color="$base0B" />
              </linearGradient>
              <linearGradient gradientUnits="userSpaceOnUse" id="linear-gradient-c6751d2115edfa2506ed6789e247b928" x1="-319.9999999999999" x2="127.99999999999996" y1="-554.2562584220408" y2="221.70250336881628">
                <stop offset="0%"   stop-color="$base0D" />
                <stop offset="25%"  stop-color="$base0D" />
                <stop offset="100%" stop-color="$base0D" />
              </linearGradient>
              <linearGradient gradientUnits="userSpaceOnUse" id="linear-gradient-6b2d1737e4a2ebfe17f3769056568c22" x1="-319.9999999999999" x2="127.99999999999996" y1="-554.2562584220408" y2="221.70250336881628">
                <stop offset="0%"   stop-color="$base0E" />
                <stop offset="25%"  stop-color="$base0E" />
                <stop offset="100%" stop-color="$base0E" />
              </linearGradient>
            </defs>
            <rect x="-3147.32" y="-3500.98" fill="$base01" width="11119.63" height="7085.97"/>
            <g transform="translate(2403.49 0)">
              <polygon fill="url(#linear-gradient-44584babfef90c4cb32c8ee42b1193ba)" points="-303.9999999999999 -304.8409421321224 -175.9999999999999 -526.5434455009388 384.00000000000006 443.40500673763256 128.00000000000006 443.40500673763256 -4.072608916703642e-14 221.70250336881628 -128.00000000000023 443.40500673763245 -256.0000000000002 443.40500673763245 -320.0000000000002 332.55375505322434 -128.0 0.0" transform="translate(-319.9999999999999 554.2562584220408) rotate(0 319.9999999999999 -554.2562584220408)"/>
              <polygon fill="url(#linear-gradient-96af2d924a4fbf5b015c244addc578a8)" points="-303.9999999999999 -304.8409421321224 -175.9999999999999 -526.5434455009388 384.00000000000006 443.40500673763256 128.00000000000006 443.40500673763256 -4.072608916703642e-14 221.70250336881628 -128.00000000000023 443.40500673763245 -256.0000000000002 443.40500673763245 -320.0000000000002 332.55375505322434 -128.0 0.0" transform="translate(-319.9999999999999 554.2562584220408) rotate(60 319.9999999999999 -554.2562584220408)"/>
              <polygon fill="url(#linear-gradient-33ff75d118a188d564af252422e7cc92)" points="-303.9999999999999 -304.8409421321224 -175.9999999999999 -526.5434455009388 384.00000000000006 443.40500673763256 128.00000000000006 443.40500673763256 -4.072608916703642e-14 221.70250336881628 -128.00000000000023 443.40500673763245 -256.0000000000002 443.40500673763245 -320.0000000000002 332.55375505322434 -128.0 0.0" transform="translate(-319.9999999999999 554.2562584220408) rotate(120 319.9999999999999 -554.2562584220408)"/>
              <polygon fill="url(#linear-gradient-2a0b6b52f041088f95dc76196e6b4d88)" points="-303.9999999999999 -304.8409421321224 -175.9999999999999 -526.5434455009388 384.00000000000006 443.40500673763256 128.00000000000006 443.40500673763256 -4.072608916703642e-14 221.70250336881628 -128.00000000000023 443.40500673763245 -256.0000000000002 443.40500673763245 -320.0000000000002 332.55375505322434 -128.0 0.0" transform="translate(-319.9999999999999 554.2562584220408) rotate(180 319.9999999999999 -554.2562584220408)"/>
              <polygon fill="url(#linear-gradient-c6751d2115edfa2506ed6789e247b928)" points="-303.9999999999999 -304.8409421321224 -175.9999999999999 -526.5434455009388 384.00000000000006 443.40500673763256 128.00000000000006 443.40500673763256 -4.072608916703642e-14 221.70250336881628 -128.00000000000023 443.40500673763245 -256.0000000000002 443.40500673763245 -320.0000000000002 332.55375505322434 -128.0 0.0" transform="translate(-319.9999999999999 554.2562584220408) rotate(240 319.9999999999999 -554.2562584220408)"/>
              <polygon fill="url(#linear-gradient-6b2d1737e4a2ebfe17f3769056568c22)" points="-303.9999999999999 -304.8409421321224 -175.9999999999999 -526.5434455009388 384.00000000000006 443.40500673763256 128.00000000000006 443.40500673763256 -4.072608916703642e-14 221.70250336881628 -128.00000000000023 443.40500673763245 -256.0000000000002 443.40500673763245 -320.0000000000002 332.55375505322434 -128.0 0.0" transform="translate(-319.9999999999999 554.2562584220408) rotate(300 319.9999999999999 -554.2562584220408)"/>
            </g>
          </svg>
        '';

        unpackPhase = ''
          runHook preUnpack
          echo "$src" > "$name.svg"
          runHook postUnpack
        '';

        patchPhase = ''
          runHook preBuild
          for environment_variable in \
            base00 base01 base02 base03 base04 base05 base06 base07 \
            base08 base09 base0A base0B base0C base0D base0E base0F
          do # substitute the value of the env var into the svg:
            value="$(eval echo \$$environment_variable)"
            sed -i "s/\\\$$environment_variable/#$value/g" "$name.svg"
          done
          runHook postBuild
        '';

        buildPhase = ''
          runHook preBuild
          python3 -m cairosvg "$name.svg" --output "$name" --output-width "$width" --output-height "$height"
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          cp "$name" "$out"
          runHook postInstall
        '';
      };

    base16Scheme =
      if config.stylix.polarity == "dark" then
        {
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
        }
      else
        {
          base00 = "eff1f5";
          base01 = "e6e9ef";
          base02 = "dce0e8";
          base03 = "a5adce";
          base04 = "bcc0cc";
          base05 = "4c4f69";
          base06 = "f2d5cf";
          base07 = "babbf1";
          base08 = "dc8a78";
          base09 = "df8e1d";
          base0A = "e5c890";
          base0B = "a6d189";
          base0C = "81c8be";
          base0D = "8caaee";
          base0E = "ca9ee6";
          base0F = "eebebe";
        };

    fonts = rec {
      serif = monospace;
      sansSerif = monospace;
      monospace.package = mkDefault pkgs.nerd-fonts.open-dyslexic;
      monospace.name = mkDefault "OpenDyslexicM Nerd Font Mono";
      emoji.package = mkDefault pkgs.noto-fonts-color-emoji;
      emoji.name = mkDefault "Noto Color Emoji";
    };

    cursor = {
      # String interpolation used to trick `typos` into
      # allowing "s"+"u"+r" instead of "sure" this one time.
      name = "WhiteS${"u"}r-cursors";
      package = pkgs."whites${"u"}r-cursors";
      size = 24;
    };
  };
}
