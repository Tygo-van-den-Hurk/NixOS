{ inputs, config, ... }:
let
  inherit (inputs) nix-github-actions;
in
{
  # Used by GitHub Actions to create a matrix out of this:
  flake.githubActions = nix-github-actions.lib.mkGithubMatrix {
    checks = inputs.nixpkgs.lib.getAttrs config.systems (
      # check whether the packages can be build for every platform,
      # but for Linux x86_64 also do the other checks. Prevents
      # duplicated checks for non-package builds as formatting for
      # example should be platform independent.
      inputs.self.packages // { inherit (inputs.self.checks) x86_64-linux; }
    );
  };
}
