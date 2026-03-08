{
  config,
  lib,
  META,
  pkgs,
  ...
}:
with lib;
let
  namespace = "self";
  module = "defaults";
  submodule = "boot";
  cfg = config.${namespace}.${module}.${submodule};
in
{
  options.${namespace}.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to this module.";
      default = config.${namespace}.${module}.enable;
      type = bool;
    };
  };

  config.boot = mkIf cfg.enable {
    loader.timeout = mkDefault 5; # seconds

    loader.grub = {
      enable = mkDefault true;
      useOSProber = mkDefault true;
      efiSupport = mkDefault true;
      memtest86.enable = mkDefault true;
      devices = [ "nodev" ];
      backgroundColor = "#${
        config.home-manager.users.${META.user.username}.stylix.base16Scheme.base01 or "000000"
      }";

      # TODO: make this theme instead a part of the styling module depending on stylix.
      theme = mkDefault (
        with pkgs;
        stdenv.mkDerivation rec {
          name = "elegant-grub2-themes";

          image = config.home-manager.users.${META.user.username}.stylix.image or null;
          polarity = config.home-manager.users.${META.user.username}.stylix.polarity or "dark";

          base00 = config.home-manager.users.${META.user.username}.stylix.base16Scheme.base00 or "FF0000";
          base01 = config.home-manager.users.${META.user.username}.stylix.base16Scheme.base01 or "242424";
          base02 = config.home-manager.users.${META.user.username}.stylix.base16Scheme.base02 or "FF0000";
          base03 = config.home-manager.users.${META.user.username}.stylix.base16Scheme.base03 or "FF0000";
          base04 = config.home-manager.users.${META.user.username}.stylix.base16Scheme.base04 or "FF0000";
          base05 = config.home-manager.users.${META.user.username}.stylix.base16Scheme.base05 or "efefef";
          base06 = config.home-manager.users.${META.user.username}.stylix.base16Scheme.base06 or "FF0000";
          base07 = config.home-manager.users.${META.user.username}.stylix.base16Scheme.base07 or "FF0000";
          base08 = config.home-manager.users.${META.user.username}.stylix.base16Scheme.base08 or "FF0000";
          base09 = config.home-manager.users.${META.user.username}.stylix.base16Scheme.base09 or "FF0000";
          base0A = config.home-manager.users.${META.user.username}.stylix.base16Scheme.base0A or "FF0000";
          base0B = config.home-manager.users.${META.user.username}.stylix.base16Scheme.base0B or "FF0000";
          base0C = config.home-manager.users.${META.user.username}.stylix.base16Scheme.base0C or "FF0000";
          base0D = config.home-manager.users.${META.user.username}.stylix.base16Scheme.base0D or "ffffff";
          base0E = config.home-manager.users.${META.user.username}.stylix.base16Scheme.base0E or "FF0000";
          base0F = config.home-manager.users.${META.user.username}.stylix.base16Scheme.base0F or "FF0000";

          screen = "1080p";

          src = fetchFromGitHub {
            owner = "vinceliuice";
            repo = "elegant-grub2-themes";
            tag = "2025-03-25";
            hash = "sha256-M9k6R/rUvEpBTSnZ2PMv5piV50rGTBrcmPU4gsS7Byg=";
          };

          patchPhase = ''
            runHook prePatch
            patchShebangs .
            runHook postPatch
          '';

          buildPhase = ''
            runHook preBuild

            mkdir -p "$PWD/theme"
            $PWD/generate.sh --dest "$PWD/theme" \
              --theme "forest" --color "$polarity" \
              --side "right" --screen "$screen" \
              --type "sharp"

            mkdir -p "$PWD/out"
            mv "$PWD/theme"/*/* "$PWD/out/"

            # injecting in the image
            if [ "$image" = "${toString null}" ]; then
              echo "no image specified"
            else
              echo "image='$image'"
              image_name="$(basename "''${image:-"$PWD/out/background.jpg"}")"
              cp "$image" "$PWD/out/$image_name"
              sed -i "s|^desktop-image: \".*\"|desktop-image: \"$image_name\"|" "$PWD/out/theme.txt"
            fi

            # injecting colors:
            sed -i "s|^color = \".*\"|color = \"#$base05\"|" "$PWD/out/theme.txt"
            sed -i "s|^item_color = \".*\"|item_color = \"#$base05\"|" "$PWD/out/theme.txt"
            sed -i "s|^selected_item_color = \".*\"|selected_item_color = \"#$base01\"|" "$PWD/out/theme.txt"
            sed -i "s|^desktop-color: \".*\"|desktop-color: \"#$base01\"|" "$PWD/out/theme.txt"
              
            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall
            mkdir -p "$out"
            cp $PWD/out/* --recursive "$out"
            runHook postInstall
          '';

          fixupPhase = ''
            runHook preFixup
            runHook postFixup
          '';
        }
      );
    };

    loader.efi = {
      canTouchEfiVariables = mkDefault true;
    };

    plymouth = {
      enable = mkDefault true;
      themePackages = [ pkgs.nixos-bgrt-plymouth ];
      theme = mkDefault "bgrt";
    };
  };
}
