let
  name = "nbcat";
in
{
  self.ci.packages.".auto--package--${name}.nix" = {
    inherit name;
    systems = [ "x86_64-linux" ];
  };

  perSystem =
    {
      pkgs,
      lib,
      ...
    }:
    with pkgs;
    with lib;
    rec {
      packages.${name} = python3Packages.buildPythonPackage rec {
        pname = "nbcat";
        version = "1.0.0";

        src = fetchFromGitHub {
          owner = "akopdev";
          repo = "nbcat";
          rev = "v${version}";
          sha256 = "sha256-DD5/KPKdz1VgPWZqjal98UrbACoVvEls/LnMY1AYRdw=";
        };

        format = "pyproject";

        nativeBuildInputs = [
          installShellFiles
          python3Packages.hatchling
        ];

        propagatedBuildInputs = with python3Packages; [
          argcomplete
          markdownify
          pydantic
          requests
          rich
          textual
          textual-image
        ];

        postInstall = ''
          installShellCompletion \
            --cmd nbcat \
            --bash ${./completions.bash}
        '';

        doInstallCheck = true;
        nativeInstallCheckInputs = [ versionCheckHook ];

        meta = with lib; {
          description = "Preview Jupyter notebooks directly in your terminal";
          license = licenses.mit;
          maintainers = with maintainers; [
            Tygo-van-den-Hurk
          ];
        };
      };

      checks.${name} = packages.${name};
    };
}
