_: {
  perSystem =
    {
      pkgs,
      config,
      self',
      ...
    }:
    let
      pure = true;

      formatters = builtins.attrValues config.treefmt.build.programs;
      hooks = config.pre-commit.settings.enabledPackages;
      packages = with pkgs; [
        act # Run your GitHub Actions locally
        git # Distributed version control system
        sops # encrypt and decrypt secrets conveniently.
        (writeShellScriptBin "apply" /* SHELL */ ''
          ${self'.apps.apply.program} # change configuration conveniently
        '')
      ];

      buildInputs = packages ++ formatters ++ hooks;

      shellHook = ''
        ${config.pre-commit.shellHook}
        if [ -f .env ]; then
          source .env
        fi
      '';
    in
    {
      devShells.default = pkgs.mkShell {
        inherit buildInputs;
        inherit shellHook;
        inherit pure;
      };
    };
}
