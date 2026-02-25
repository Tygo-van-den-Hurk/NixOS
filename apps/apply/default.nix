_: {
  perSystem =
    {
      inputs',
      pkgs,
      lib,
      ...
    }:
    with pkgs;
    let
      name = "apply";
      package = stdenv.mkDerivation rec {
        inherit name;
        src = ./.;

        nativeBuildInputs = [ makeWrapper ];

        installPhase = ''
          runHook preInstall

          mkdir --parents $out/share/bash-completion/completions
          cp ${src}/completions.bash $out/share/bash-completion/completions/${name}.bash

          mkdir --parents $out/bin
          cp ${src}/script.bash $out/bin/${name}

          runHook postInstall
        '';

        fixupPhase = ''
          runHook preFixup

          patchShebangs $out/bin/${name}
          wrapProgram $out/bin/${name} --prefix PATH : ${
            lib.makeBinPath [
              inputs'.home-manager.packages.home-manager
              nixos-rebuild
              busybox
              nix
            ]
          }

          runHook postFixup
        '';

        meta = with lib; {
          description = "Conveniently build and switch to your new configuration.";
          homepage = "https://github.com/Tygo-van-den-Hurk/NixOS";
          license = with licenses; [ epl20 ];
          maintainers = with maintainers; [ Tygo-van-den-Hurk ];
          mainProgram = name;
        };
      };
    in
    {
      apps.${name} = {
        program = lib.getExe package;
        inherit (package) meta;
      };
    };
}
