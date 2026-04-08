{ inputs, ... }:
{
  # When applied, the unstable nixpkgs set (declared in the flake inputs) will be accessible through 'pkgs.unstable'.
  flake.overlays.unstable-packages = _: previous: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (previous.stdenv) system;
      overlays = [ ];
    };
  };

  # When applied, adds the packages of this flake to the package set.
  flake.overlays.packages =
    _: previous:
    let
      inherit (previous.stdenv) system;
    in
    inputs.self.packages.${system};
}
