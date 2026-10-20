let
  inherit (import ./values.lib.nix) steps;
in
{
  perSystem = { system, ... }: {
    githubActions.workflows."many--check-neovim-config.nix" = {
      name = "Validating 'NeoVim' configuration";

      on = rec {
        # pull_request = push; # option not defined yet...
        push = {
          branches = [ "main" ];
          paths = [
            "packages/neovim/**"
            "modules/neovim/**"
            "flake.lock"
            "lib/**"
          ];
        };
      };

      jobs.build = {
        name = "Validating 'NeoVim' configuration";
        runsOn = if system == "x86_64-linux" then "ubuntu-latest" else "ubuntu-arm-latest";
        timeoutMinutes = 10;
        steps = [
          steps.checkout-repository
          steps.install-nix
          (steps.nix-build {
            name = "Validating 'NeoVim' configuration using fake secrets";
            attr = "checks.${system}.neovim";
          })
        ];
      };
    };
  };
}
