_: {
  perSystem =
    {
      pkgs,
      lib,
      ...
    }:
    with pkgs;
    let
      name = "apply";
      runtimeDependencies = [];
      package = stdenv.mkDerivation rec {
        inherit name;
        src = ./.;

        nativeBuildInputs = runtimeDependencies ++ [ makeWrapper ];

        installPhase = ''
          runHook preInstall

          mkdir --parents $out/share/bash-completion/completions
          cp ${src}/completions.bash $out/share/bash-completion/completions/${name}.bash

          mkdir --parents $out/bin
          cp ${src}/script.bash $out/bin/${name}
          patchShebangs $out/bin/${name}
          wrapProgram $out/bin/${name} --prefix PATH : ${lib.makeBinPath runtimeDependencies}

          runHook postInstall
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
