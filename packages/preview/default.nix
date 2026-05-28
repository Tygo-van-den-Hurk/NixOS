let
  name = "preview";
in
{
  perSystem =
    {
      self',
      pkgs,
      lib,
      ...
    }:
    with pkgs;
    with lib;
    rec {
      packages."${name}/script" = writeShellApplication {
        inherit name;

        text = builtins.readFile ./script.bash;

        runtimeInputs = [
          self'.packages.nbcat
          chafa
          glow
          file
          eza
          poppler-utils
          gnugrep
          toybox
        ];

        meta = {
          description = "Preview all sorts of files directly in your terminal";
          license = with licenses; epl20;
          maintainers = with maintainers; [
            Tygo-van-den-Hurk
          ];
        };
      };

      packages."${name}/completions" = stdenvNoCC.mkDerivation {
        inherit name;

        dontUnpack = true;
        nativeBuildInputs = [ installShellFiles ];
        inherit (self'.packages."${name}/script") meta;

        installPhase = ''
          runHook preInstall

          installShellCompletion \
            --cmd "$name" \
            --bash ${./completions.bash}

          runHook postInstall
        '';
      };

      packages.${name} = symlinkJoin {
        inherit name;
        inherit (self'.packages."${name}/script") meta;
        paths = [
          self'.packages."${name}/script"
          self'.packages."${name}/completions"
        ];
      };

      checks.${name} = packages.${name};
    };
}
