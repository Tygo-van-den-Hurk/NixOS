{ inputs, ... }:
{
  # When applied, the unstable nixpkgs set (declared in the flake inputs) will be accessible through 'pkgs.unstable'.
  flake.overlays.unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      # inherit (final) config;
      overlays = [ ];
    };
  };
}
